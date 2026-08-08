class AppNotification {
  final String id;
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final DateTime receivedAt;
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.data,
    required this.receivedAt,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'data': data,
    'receivedAt': receivedAt.toIso8601String(),
    'isRead': isRead,
  };

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      data: Map<String, dynamic>.from(json['data'] ?? {}),
      receivedAt: DateTime.parse(json['receivedAt']),
      isRead: json['isRead'] ?? false,
    );
  }

  factory AppNotification.fromBackendJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      body: json['body'] ?? json['message'] ?? '',
      data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : {},
      receivedAt: DateTime.parse(json['created_at']).toLocal(),
      isRead: json['is_read'] == true || json['is_read'] == 1,
    );
  }
}