import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/core/errors/failure.dart';

void main() {
  group('Failure Tests', () {
    test(
      'ServerFailure should hold correct message and be a Failure instance',
      () {
        const message = 'Internal Server Error';
        const failure = ServerFailure(message);

        expect(failure.message, equals(message));
        expect(failure, isA<Failure>());
        expect(failure, isA<ServerFailure>());
      },
    );

    test(
      'OfflineFailure should hold correct message and be a Failure instance',
      () {
        const message = 'No Internet Connection';
        const failure = OfflineFailure(message);

        expect(failure.message, equals(message));
        expect(failure, isA<Failure>());
        expect(failure, isA<OfflineFailure>());
      },
    );
  });
}
