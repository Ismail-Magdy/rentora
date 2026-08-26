import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/core/network/firebase/users_firestore_service.dart';
import 'package:rentora/features/setup_profile/data/repos/setup_profile_repo.dart';

class MockUsersFirestoreService extends Mock implements UsersFirestoreService {}

void main() {
  late MockUsersFirestoreService usersService;
  late SetupProfileRepo repo;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    usersService = MockUsersFirestoreService();
    repo = SetupProfileRepo(usersService);
  });

  group('SetupProfileRepo', () {
    test('saveUserLocation updates the user profile with location data',
        () async {
      when(
        () => usersService.updateUserProfile(
          userId: 'user_1',
          updatedData: any(named: 'updatedData'),
        ),
      ).thenAnswer((_) async {});

      final result = await repo.saveUserLocation(
        userId: 'user_1',
        location: const GeoPoint(30.0, 31.0),
        address: 'Downtown, Cairo',
        geohash: 'stq4y',
      );

      expect(result.isRight(), isTrue);
      final captured = verify(
        () => usersService.updateUserProfile(
          userId: 'user_1',
          updatedData: captureAny(named: 'updatedData'),
        ),
      ).captured.single as Map<String, dynamic>;

      final location = captured['location'] as GeoPoint;
      expect(location.latitude, equals(30.0));
      expect(location.longitude, equals(31.0));
      expect(captured['locationName'], equals('Downtown, Cairo'));
      expect(captured['geohash'], equals('stq4y'));
    });

    test('saveUserLocation maps thrown exceptions to ServerFailure', () async {
      when(
        () => usersService.updateUserProfile(
          userId: any(named: 'userId'),
          updatedData: any(named: 'updatedData'),
        ),
      ).thenThrow(
        FirebaseException(
          plugin: 'firestore',
          code: 'permission-denied',
          message: 'Denied',
        ),
      );

      final result = await repo.saveUserLocation(
        userId: 'user_1',
        location: const GeoPoint(30.0, 31.0),
        address: 'Downtown, Cairo',
        geohash: 'stq4y',
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
          failure.message,
          equals('You do not have permission to perform this action'),
        ),
        (_) => fail('Expected failure'),
      );
    });

    test('saveUserInterests persists interests successfully', () async {
      when(
        () => usersService.updateUserProfile(
          userId: 'user_1',
          updatedData: any(named: 'updatedData'),
        ),
      ).thenAnswer((_) async {});

      final result = await repo.saveUserInterests(
        userId: 'user_1',
        interests: ['Cameras', 'Gaming'],
      );

      expect(result.isRight(), isTrue);
      final captured = verify(
        () => usersService.updateUserProfile(
          userId: 'user_1',
          updatedData: captureAny(named: 'updatedData'),
        ),
      ).captured.single as Map<String, dynamic>;

      expect(captured['interests'], equals(['Cameras', 'Gaming']));
    });

    test('saveUserInterests maps generic errors to ServerFailure', () async {
      when(
        () => usersService.updateUserProfile(
          userId: any(named: 'userId'),
          updatedData: any(named: 'updatedData'),
        ),
      ).thenThrow(Exception('boom'));

      final result = await repo.saveUserInterests(
        userId: 'user_1',
        interests: ['Cameras'],
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
          failure.message,
          equals('An unexpected error occurred. Please try again later'),
        ),
        (_) => fail('Expected failure'),
      );
    });
  });
}
