abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'serverErrorDefault',
  ]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'networkErrorDefault',
  ]);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'sessionExpired',
  ]);
}

class ValidationFailure extends Failure {
  const ValidationFailure([
    super.message = 'validationErrorDefault',
  ]);
}

class CacheFailure extends Failure {
  const CacheFailure([
    super.message = 'cacheErrorDefault',
  ]);
}