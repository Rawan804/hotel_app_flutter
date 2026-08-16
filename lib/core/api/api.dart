class ApiConstants {
  ApiConstants._();

  static const String host = "https://hotel-management-system-production-97bb.up.railway.app";
  static const String baseUrl = "$host/api";
  static String imageUrl(String relativePath) {
    if (relativePath.isEmpty) return '';
    if (relativePath.startsWith('http://') || relativePath.startsWith('https://')) {
      return relativePath;
    }
    final cleanPath = relativePath.startsWith('/')
        ? relativePath.substring(1)
        : relativePath;
    return '$host/$cleanPath';
  }
}