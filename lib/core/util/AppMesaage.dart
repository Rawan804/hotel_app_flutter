import 'package:flutter/material.dart';

/// ⭐ مفتاح عام (Global) لـ ScaffoldMessenger موصول مباشرة بالـ MaterialApp
/// (شوف main.dart: MaterialApp(scaffoldMessengerKey: rootScaffoldMessengerKey, ...)).
///
/// ليش هاد الحل؟
/// لما تعرض SnackBar من جوا showModalBottomSheet أو showDialog، الـ context
/// يلي عندك هناك مش جزء فعلي من شجرة الـ Scaffold تبع الصفحة يلي فوقها
/// الـ Modal — هو overlay/route منفصل. فـ ScaffoldMessenger.of(context)
/// بيلاقي إما ScaffoldMessenger غلط، أو صح بس بيصطدم بمشاكل توقيت أثناء
/// أنيميشن إغلاق الشيت (الرسالة بتنعرض بس تضل مخفية وراء الشيت لحظة
/// ما يسكر).
///
/// باستخدام هاد المفتاح العام، منقدر نعرض SnackBar من أي مكان بالتطبيق —
/// بغض النظر وين الـ context موجود بالشجرة — وبيطلع فوراً وفوق كل شي.
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();

/// دالة مختصرة لعرض رسالة SnackBar من أي مكان بالتطبيق (حتى من جوا
/// Modal/Dialog/Bottom Sheet) بدون الحاجة لـ context خالص.
void showGlobalSnackBar(
    String message, {
      Color? backgroundColor,
      Duration duration = const Duration(seconds: 3),
    }) {
  rootScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: duration,
    ),
  );
}