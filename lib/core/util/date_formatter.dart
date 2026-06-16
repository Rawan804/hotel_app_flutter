import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  final dateTime = DateTime.parse(dateStr);
  return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
}