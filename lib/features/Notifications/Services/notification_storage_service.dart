import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/app_notification.dart';
import 'package:flutter/foundation.dart';

final ValueNotifier<int> notificationsNotifier = ValueNotifier<int>(0);

abstract class NotificationStorage {
  Future<void> add(AppNotification notification);
  Future<List<AppNotification>> getAll();
  Future<void> markAsRead(int index);
  Future<void> markAsReadById(String id);
  Future<void> delete(int index);
  Future<void> deleteById(String id);
  Future<void> deleteAll();
  Future<int> unreadCount();
  Future<void> replaceAll(List<AppNotification> list);

  Future<Set<String>> getDeletedIds();
  Future<void> addDeletedId(String id);
  Future<void> addDeletedIds(List<String> ids);
}

/// تخزين الإشعارات محلياً — كل يوزر (حسب الإيميل المخزّن بعد تسجيل الدخول)
/// إله مفتاح تخزين منفصل بالـ SharedPreferences، فما بيصير خلط بين سجلات
/// المستخدمين المختلفين على نفس الجهاز.
class SharedPrefsNotificationStorage implements NotificationStorage {
  static const String _keyPrefix = 'stored_notifications_';
  static const String _deletedKeyPrefix = 'deleted_notification_ids_';
  static const String _emailKey = 'user_email';

  static const int _maxStored = 100;
  static const int _maxDeletedStored = 300;

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  /// يرجّع معرّف اليوزر الحالي (الإيميل)، أو 'guest' إذا ما في يوزر مسجل دخول.
  Future<String> _userSuffix() async {
    final prefs = await _prefs;
    final email = prefs.getString(_emailKey);
    if (email == null || email.trim().isEmpty) return 'guest';
    // توحيد الحالة (حروف صغيرة + إزالة مسافات) حتى ما يصير فرق بين
    // Test@mail.com و test@mail.com
    return email.trim().toLowerCase();
  }

  Future<String> _keyFor() async => '$_keyPrefix${await _userSuffix()}';

  Future<String> _deletedKeyFor() async =>
      '$_deletedKeyPrefix${await _userSuffix()}';

  @override
  Future<void> add(AppNotification notification) async {
    final prefs = await _prefs;
    final key = await _keyFor();
    final list = await getAll();

    if (list.any((n) => n.id == notification.id && n.id.isNotEmpty)) {
      return;
    }

    list.insert(0, notification);

    if (list.length > _maxStored) {
      list.removeRange(_maxStored, list.length);
    }

    final encoded = list.map((n) => jsonEncode(n.toJson())).toList();
    await prefs.setStringList(key, encoded);

    if (notification.id.isNotEmpty) {
      final deletedKey = await _deletedKeyFor();
      final deleted = await getDeletedIds();
      if (deleted.contains(notification.id)) {
        deleted.remove(notification.id);
        await prefs.setStringList(deletedKey, deleted.toList());
      }
    }

    notificationsNotifier.value++;
  }

  @override
  Future<List<AppNotification>> getAll() async {
    final prefs = await _prefs;
    final key = await _keyFor();
    final raw = prefs.getStringList(key) ?? [];
    return raw.map((s) => AppNotification.fromJson(jsonDecode(s))).toList();
  }

  @override
  Future<void> replaceAll(List<AppNotification> finalList) async {
    final prefs = await _prefs;
    final key = await _keyFor();
    final encoded = finalList.map((n) => jsonEncode(n.toJson())).toList();
    await prefs.setStringList(key, encoded);
  }

  @override
  Future<void> markAsRead(int index) async {
    final prefs = await _prefs;
    final key = await _keyFor();
    final list = await getAll();
    if (index < 0 || index >= list.length) return;
    list[index].isRead = true;
    final encoded = list.map((n) => jsonEncode(n.toJson())).toList();
    await prefs.setStringList(key, encoded);
    notificationsNotifier.value++;
  }

  @override
  Future<void> delete(int index) async {
    final prefs = await _prefs;
    final key = await _keyFor();
    final list = await getAll();
    if (index < 0 || index >= list.length) return;

    final removed = list.removeAt(index);
    if (removed.id.isNotEmpty) {
      await addDeletedId(removed.id);
    }

    final encoded = list.map((n) => jsonEncode(n.toJson())).toList();
    await prefs.setStringList(key, encoded);
    notificationsNotifier.value++;
  }

  @override
  Future<void> deleteAll() async {
    final prefs = await _prefs;
    final key = await _keyFor();

    final list = await getAll();
    final ids = list.map((n) => n.id).where((id) => id.isNotEmpty).toList();
    await addDeletedIds(ids);

    await prefs.remove(key);
    notificationsNotifier.value++;
  }

  @override
  Future<void> deleteById(String id) async {
    final prefs = await _prefs;
    final key = await _keyFor();
    final list = await getAll();

    list.removeWhere((n) => n.id == id);

    if (id.isNotEmpty) {
      await addDeletedId(id);
    }

    final encoded = list.map((n) => jsonEncode(n.toJson())).toList();
    await prefs.setStringList(key, encoded);
    notificationsNotifier.value++;
  }

  @override
  Future<void> markAsReadById(String id) async {
    final prefs = await _prefs;
    final key = await _keyFor();
    final list = await getAll();
    final index = list.indexWhere((n) => n.id == id);
    if (index == -1) return;
    list[index].isRead = true;
    final encoded = list.map((n) => jsonEncode(n.toJson())).toList();
    await prefs.setStringList(key, encoded);
    notificationsNotifier.value++;
  }

  @override
  Future<int> unreadCount() async {
    final list = await getAll();
    return list.where((n) => !n.isRead).length;
  }

  @override
  Future<Set<String>> getDeletedIds() async {
    final prefs = await _prefs;
    final deletedKey = await _deletedKeyFor();
    final raw = prefs.getStringList(deletedKey) ?? [];
    return raw.toSet();
  }

  @override
  Future<void> addDeletedId(String id) async {
    await addDeletedIds([id]);
  }

  @override
  Future<void> addDeletedIds(List<String> ids) async {
    if (ids.isEmpty) return;
    final prefs = await _prefs;
    final deletedKey = await _deletedKeyFor();
    final current = await getDeletedIds();
    current.addAll(ids.where((e) => e.isNotEmpty));

    var list = current.toList();
    if (list.length > _maxDeletedStored) {
      list = list.sublist(list.length - _maxDeletedStored);
    }

    await prefs.setStringList(deletedKey, list);
  }
}