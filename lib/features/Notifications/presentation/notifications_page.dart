import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_app/core/constants/app_colors.dart';
import 'package:hotel_app/features/news/presentation/widgets/BottomBar/bottombar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/api/api.dart';
import '../../Auth/data/datasource/auth_local_datasource.dart';
import '../Services/notification_storage_service.dart';
import '../model/app_notification.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationStorage _storage = SharedPrefsNotificationStorage();
  List<AppNotification> _notifications = [];
  bool _loading = true;
  late final VoidCallback _notificationsListener;

  @override
  void initState() {
    super.initState();

    _loadNotifications();

    _notificationsListener = () {
      _loadNotifications();
    };

    notificationsNotifier.addListener(_notificationsListener);
  }

  @override
  void dispose() {
    notificationsNotifier.removeListener(_notificationsListener);
    super.dispose();
  }

  Future<void> _loadNotifications() async {
    setState(() => _loading = true);

    final localList = await _storage.getAll();
    final deletedIds = await _storage.getDeletedIds();

    try {
      final prefs = await SharedPreferences.getInstance();
      final authLocalDataSource = AuthLocalDataSourceImpl(prefs);
      final authToken = await authLocalDataSource.getToken();

      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/notifications'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final serverData = body['data'] as List;

        final serverList = serverData
            .map((e) => AppNotification.fromBackendJson(e))
            .toList();

        final Map<String, AppNotification> merged = {
          for (var n in localList) n.id: n,
        };
        for (var n in serverList) {
          merged[n.id] = n;
        }

        final result = merged.values
            .where((n) => !deletedIds.contains(n.id))
            .toList()
          ..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));

        await _storage.replaceAll(result);

        result.sort((a, b) {
          if (a.isRead != b.isRead) {
            return a.isRead ? 1 : -1;
          }
          return b.receivedAt.compareTo(a.receivedAt);
        });

        setState(() {
          _notifications = result;
          _loading = false;
        });
        return;
      }
    } catch (e) {
      print('⚠️ فشل جلب من السيرفر، بنعرض المحلي فقط: $e');
    }

    final filteredLocal = localList
        .where((n) => !deletedIds.contains(n.id))
        .toList();

    setState(() {
      _notifications = filteredLocal
        ..sort((a, b) => (a.isRead == b.isRead) ? 0 : a.isRead ? 1 : -1);
      _loading = false;
    });
  }

  Future<void> _deleteAllNotifications() async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد أنك تريد حذف جميع الإشعارات؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _storage.deleteAll();
      _loadNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      bottomNavigationBar: Bottombar(),
      appBar: AppBar(
        title: Text(
          'الإشعارات',
          style: textTheme.displayMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 20,
        centerTitle: false,
        backgroundColor: colors.surface,
        elevation: 0,
      ),
      body: _loading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
        ),
      )
          : _notifications.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 80,
              color: colors.onSurface.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'لا يوجد إشعارات بعد',
              style: textTheme.titleLarge?.copyWith(
                color: colors.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'عندما تتلقى إشعارات، ستظهر هنا.',
              style: textTheme.bodyMedium?.copyWith(
                color: colors.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final n = _notifications[index];
          return Dismissible(
            key: ValueKey(n.id.isNotEmpty ? n.id : '${n.receivedAt.microsecondsSinceEpoch}_${n.title}'),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              return await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('حذف الإشعار'),
                  content: const Text('هل تريد حذف هذا الإشعار؟'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('حذف'),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (_) async {
              final deletedNotification = _notifications[index];

              await _storage.deleteById(deletedNotification.id);

              _loadNotifications();

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.white,
                  content: const Text('تم حذف الإشعار', style: TextStyle(color: Colors.black)),
                  action: SnackBarAction(
                    textColor: Colors.red,
                    label: 'تراجع',
                    onPressed: () async {
                      await _storage.add(deletedNotification);
                      _loadNotifications();
                    },
                  ),
                ),
              );
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.delete_rounded,
                color: colors.surface,
                size: 30,
              ),
            ),
            child: Card(
              margin: const EdgeInsets.only(bottom: 15, top: 12),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: n.isRead
                    ? BorderSide(color: colors.onSurface.withOpacity(0.02), width: 1)
                    : BorderSide(color: colors.surface, width: 1.6),
              ),
              color: theme.scaffoldBackgroundColor,
              child: InkWell(
                onTap: () async {
                  if (!n.isRead) {
                    await _storage.markAsReadById(n.id);

                    try {
                      final prefs = await SharedPreferences.getInstance();
                      final authLocalDataSource = AuthLocalDataSourceImpl(prefs);
                      final authToken = await authLocalDataSource.getToken();

                      await http.put(
                        Uri.parse('${ApiConstants.baseUrl}/notifications/${n.id}/read'),
                        headers: {'Authorization': 'Bearer $authToken'},
                      );
                    } catch (e) {
                      print('⚠️ فشل تحديث حالة القراءة بالسيرفر: $e');
                    }

                    _loadNotifications();
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        n.isRead ? Icons.notifications_none : Icons.notifications_active,
                        color: n.isRead ? theme.cardColor : theme.cardColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    n.title,
                                    style: textTheme.displayMedium?.copyWith(
                                      fontSize: 15,
                                      color: colors.onSurface,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  DateFormat('dd/MM  hh:mm a').format(n.receivedAt),
                                  style: textTheme.displayMedium?.copyWith(
                                    fontSize: 13,
                                    color: colors.onSurface.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              n.body,
                              style: textTheme.displayMedium?.copyWith(
                                fontSize: 12,
                                color: colors.onSurface.withOpacity(0.8),
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}