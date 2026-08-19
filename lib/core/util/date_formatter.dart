import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  final dateTime = DateTime.parse(dateStr);
  return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
}

Color getStatusColor(String status) {
  switch (status.trim().toLowerCase()) {
    case 'completed':
    case 'منتهية':
    case 'مكتمل':
    case 'مكتملة':
      return Colors.green;
    case 'in progress':
    case 'in_progress':
    case 'جارٍ التنفيذ':
    case 'جاري التنفيذ':
      return Colors.orange;
    case 'pending':
    case 'قيد الانتظار':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

/// يفحص إذا حالة المهمة "مكتملة"، بمعزل عن اللغة الحالية للتطبيق.
/// استخدم هاي الدالة دايمًا بدل مقارنة status.toLowerCase() == 'completed'
/// مباشرة، لأنه status نص مترجم من الباك اند وبيختلف شكله حسب اللغة.
bool isTaskCompleted(String status) {
  const completedVariants = {'completed', 'منتهية', 'مكتمل', 'مكتملة'};
  return completedVariants.contains(status.trim().toLowerCase());
}

/// نفس الفكرة، لحالة "قيد الانتظار" - استخدمها بدل status == 'pending' مباشرة.
bool isTaskPending(String status) {
  const pendingVariants = {'pending', 'قيد الانتظار'};
  return pendingVariants.contains(status.trim().toLowerCase());
}