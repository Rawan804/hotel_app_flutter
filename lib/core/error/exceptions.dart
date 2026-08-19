class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({
    this.message = 'serverErrorDefault',
    this.statusCode,
  });
}

class NetworkException implements Exception {
  final String message;

  NetworkException({
    this.message = 'networkErrorDefault',
  });
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException({
    this.message = 'sessionExpired',
  });
}

class ValidationException implements Exception {
  final String message;

  ValidationException({
    this.message = 'validationErrorDefault',
  });
}

class CacheException implements Exception {
  final String message;

  CacheException({
    this.message = 'cacheErrorDefault',
  });
}