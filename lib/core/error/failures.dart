
library;
abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

/// خطأ سيرفر (مثال: 500، أو استجابة غير متوقعة).
class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'حدث خطأ من جهتنا، حاول مرة أخرى لاحقًا',
  ]);
}

/// عدم وجود إنترنت أو Timeout.
class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'تأكد من اتصالك بالإنترنت وحاول مرة أخرى',
  ]);
}

/// انتهاء الجلسة / عدم وجود صلاحية (401 / 403).
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'انتهت صلاحية جلستك، سجل الدخول من جديد',
  ]);
}

/// بيانات مدخلة غير صالحة (422 غالبًا) — الرسالة هون بتكون غالبًا جاية من السيرفر مباشرة.
class ValidationFailure extends Failure {
  const ValidationFailure([
    super.message = 'يرجى التحقق من البيانات المدخلة',
  ]);
}

/// خطأ بالتخزين أو القراءة المحلية.
class CacheFailure extends Failure {
  const CacheFailure([
    super.message = 'حدث خطأ أثناء قراءة البيانات المحفوظة',
  ]);
}