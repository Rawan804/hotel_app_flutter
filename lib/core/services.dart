// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;
//
// class NotificationService {
//   static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//
//   static Future<void> initialize() async {
//     // 1. اطلب الإذن (مهم لـ iOS)
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('✅ الإذن ممنوح');
//     }
//
//     // 2. احصل على الـ FCM Token وأرسله للـ Backend
//     String? token = await _messaging.getToken();
//     print('FCM Token: $token');
//
//     if (token != null) {
//       await _sendTokenToBackend(token); // ← مهم جدًا!
//     }
//
//     // 3. تحديث الـ token إذا تغيّر
//     _messaging.onTokenRefresh.listen((newToken) {
//       _sendTokenToBackend(newToken);
//     });
//
//     // 4. التعامل مع الإشعارات حسب حالة التطبيق
//     _setupMessageHandlers();
//   }
//
//   static void _setupMessageHandlers() {
//     // التطبيق مفتوح (Foreground)
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('📱 إشعار وصل والتطبيق مفتوح');
//       print('Title: ${message.notification?.title}');
//       print('Body: ${message.notification?.body}');
//       print('Data: ${message.data}'); // البيانات الإضافية من الـ Backend
//
//       // هنا تعرض dialog أو snackbar للمستخدم
//     //  _showInAppNotification(message);
//     });
//
//     // المستخدم ضغط على الإشعار والتطبيق كان في الخلفية
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('🔔 المستخدم فتح الإشعار');
//       _handleNotificationTap(message.data);
//     });
//   }
//
//   // إرسال الـ token للـ Backend
//   static Future<void> _sendTokenToBackend(String token) async {
//     await http.post(
//       Uri.parse('https://your-api.com/api/save-token'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'token': token,
//         'userId': 'USER_ID_HERE', // من الـ auth
//       }),
//     );
//   }
//
//   // التعامل مع الضغط على الإشعار
//   static void _handleNotificationTap(Map<String, dynamic> data) {
//     final screen = data['screen'];
//     if (screen == 'order') {
//       // Navigate to order screen
//     } else if (screen == 'chat') {
//       // Navigate to chat screen
//     }
//   }
// }