import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'exceptions.dart';
Future<http.Response> runHttpCall(
    Future<http.Response> Function() call,
    ) async {
  try {
    return await call().timeout(const Duration(seconds: 20));
  } on SocketException {
    throw NetworkException();
  } on TimeoutException {
    throw NetworkException(
      message: 'استغرق الاتصال وقتًا طويلاً، حاول مرة أخرى',
    );
  } on HttpException {
    throw NetworkException();
  } on FormatException {
    throw ServerException(message: 'استجابة غير متوقعة من السيرفر');
  }
}
Never throwApiException(http.Response response) {
  final serverMessage = _extractMessage(response.body);

  switch (response.statusCode) {
    case 401:
    case 403:
      throw UnauthorizedException(
        message: serverMessage ?? 'انتهت صلاحية جلستك، سجل الدخول من جديد',
      );
    case 422:
      throw ValidationException(
        message: serverMessage ?? 'يرجى التحقق من البيانات المدخلة',
      );
    case 404:
      throw ServerException(
        message: serverMessage ?? 'لم يتم العثور على البيانات المطلوبة',
        statusCode: response.statusCode,
      );
    default:
      throw ServerException(
        message: serverMessage ?? 'حدث خطأ من جهتنا، حاول مرة أخرى لاحقًا',
        statusCode: response.statusCode,
      );
  }
}
String? _extractMessage(String body) {
  if (body.isEmpty) return null;
  try {
    final decoded = json.decode(body);
    if (decoded is Map) {
      final direct = decoded['message'] ?? decoded['error'];
      if (direct is String && direct.trim().isNotEmpty) {
        return direct;
      }

      final errors = decoded['errors'];
      if (errors is Map) {
        for (final value in errors.values) {
          if (value is List && value.isNotEmpty) {
            return value.first.toString();
          }
          if (value is String && value.trim().isNotEmpty) {
            return value;
          }
        }
      }
    }
  } catch (_) {
  }
  return null;
}