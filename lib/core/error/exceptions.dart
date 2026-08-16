library;
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({
    this.message = 'حدث خطأ من جهتنا، حاول مرة أخرى لاحقًا',
    this.statusCode,
  });
}
class NetworkException implements Exception {
  final String message;

  NetworkException({
    this.message = 'تأكد من اتصالك بالإنترنت وحاول مرة أخرى',
  });
}
class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException({
    this.message = 'انتهت صلاحية جلستك، سجل الدخول من جديد',
  });
}
class ValidationException implements Exception {
  final String message;

  ValidationException({
    this.message = 'يرجى التحقق من البيانات المدخلة',
  });
}
class CacheException implements Exception {
  final String message;

  CacheException({
    this.message = 'حدث خطأ أثناء قراءة البيانات المحفوظة',
  });
}