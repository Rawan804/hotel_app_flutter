import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../features/Auth/data/datasource/auth_local_datasource.dart';
import '../features/Notifications/Services/notification_storage_service.dart';
import '../features/Notifications/model/app_notification.dart';
import 'api/api.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String BASE_URL= ApiConstants.baseUrl;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();
  static final NotificationStorage _storage = SharedPrefsNotificationStorage();
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings =
    InitializationSettings(android: androidInit);
    await _localNotifications.initialize(settings: initSettings);

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ الإذن ممنوح');
    } else {
      print('⚠️ الإذن غير ممنوح: ${settings.authorizationStatus}');
    }
    String? token = await _messaging.getToken();
    print('FCM Token: $token');
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("Initial Message: $message");
      if (message != null) {
        _saveNotification(message);
        _handleNotificationTap(message.data);
      }
    });
    if (token != null) {
      await _sendTokenToBackend(token);
    }
    _messaging.onTokenRefresh.listen((newToken) {
      print('🔄 Token refreshed: $newToken');
      _sendTokenToBackend(newToken);
    });
    _setupMessageHandlers();
  }
  static void _setupMessageHandlers() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("======== NEW MESSAGE ========");
      print("Notification: ${message.notification}");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
      print("Data: ${message.data}");

      _saveNotification(message);
      _showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🔔 المستخدم فتح الإشعار');
      print("Notification: ${message.notification}");
      print("Data: ${message.data}");

      _saveNotification(message);
      _handleNotificationTap(message.data);
    });
  }
  static Future<void> _saveNotification(RemoteMessage message) async {
    final notification = message.notification;

    // إذا كان من الباك إند لا تحفظيه محلياً
    if (message.data.containsKey('type')) {
      // هذا إشعار من الباك إند
      return;
    }
    await _storage.add(
      AppNotification(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: notification?.title ?? '',
        body: notification?.body ?? '',
        data: message.data,
        receivedAt: DateTime.now(),
      ),
    );
  }
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      await _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.data),
      );}}
  /// يُستدعى بعد نجاح تسجيل الدخول مباشرة، عشان الباك اند يعرف الـ FCM token
  /// تبع هالجهاز حتى لو أول مرة فُتح فيها التطبيق كان المستخدم غير مسجل دخول.
  static Future<void> sendCurrentTokenToBackend() async {
    final token = await _messaging.getToken();
    if (token != null) {
      await _sendTokenToBackend(token);
    }
  }
  static Future<void> _sendTokenToBackend(String fcmToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final authLocalDataSource = AuthLocalDataSourceImpl(prefs);
      final authToken = await authLocalDataSource.getToken();
      print("AUTH TOKEN: $authToken");
      if (authToken == null) {
        print('⚠️ ما في يوزر مسجل دخول، تخطي إرسال الـ FCM token');
        return;
      }
      final response = await http.post(
        Uri.parse('$BASE_URL/staff/firebase-token'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({
          'fcm_token': fcmToken,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Token sent successfully');
      } else {
        print('📡 Token send status: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('❌ فشل إرسال التوكن للباك اند: $e');
    }
  }
  // التعامل مع الضغط على الإشعار
  static void _handleNotificationTap(Map<String, dynamic> data) {
    final screen = data['screen'];
    if (screen == 'order') {
      // Navigate to order screen
    } else if (screen == 'chat') {
      // Navigate to chat screen
    }
  }
}