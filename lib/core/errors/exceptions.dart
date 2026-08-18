class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class OfflineException implements Exception {
  final String message;
  const OfflineException(this.message);
}
