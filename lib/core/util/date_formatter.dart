import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  final dateTime = DateTime.parse(dateStr);
  return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
}

Color getStatusColor(String status) {
  switch (status) {
    case 'Completed':
      return Colors.green;
    case 'completed':
      return Colors.green;
    case 'منتهية':
      return Colors.green;
    case 'In Progress':
      return Colors.orange;
    case 'in_progress':
      return Colors.orange;
    case 'جارٍ التنفيذ':
      return Colors.orange;
    case 'Pending':
      return Colors.red;
    case 'pending':
      return Colors.red;
    case 'قيد الانتظار':
      return Colors.red;

    default:
      return Colors.grey;
  }
}