import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/core/errors/exceptions.dart';

void main() {
  group('Exceptions Tests', () {
    test('ServerException should store message', () {
      const exception = ServerException('Server error occurred');
      expect(exception.message, 'Server error occurred');
      expect(exception, isA<Exception>());
    });

    test('OfflineException should store message', () {
      const exception = OfflineException('No internet connection');
      expect(exception.message, 'No internet connection');
      expect(exception, isA<Exception>());
    });
  });
}
