import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/exceptions.dart';
import 'package:rentora/core/network/firebase/cloudinary_service.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/core/network/firebase/users_firestore_service.dart';
import 'package:rentora/features/auth/data/models/user_model.dart';
import 'package:rentora/features/profile/data/repo/profile_repo.dart';

class MockUsersFirestoreService extends Mock implements UsersFirestoreService {}

class MockCloudinaryService extends Mock implements CloudinaryService {}

class MockFirebaseAuthService extends Mock implements FirebaseAuthService {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockUsersFirestoreService usersService;
  late MockCloudinaryService cloudinaryService;
  late MockFirebaseAuthService authService;
  late ProfileRepo repo;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    usersService = MockUsersFirestoreService();
    cloudinaryService = MockCloudinaryService();
    authService = MockFirebaseAuthService();
    repo = ProfileRepo(
      usersService: usersService,
      cloudinaryService: cloudinaryService,
      authService: authService,
    );
  });

  MockDocumentSnapshot buildUserDoc(Map<String, dynamic> data) {
    final doc = MockDocumentSnapshot();
    when(() => doc.exists).thenReturn(true);
    when(() => doc.data()).thenReturn(data);
    return doc;
  }

  group('ProfileRepo', () {
    test('throws when user is not authenticated', () async {
      when(() => authService.getCurrentUserId()).thenReturn(null);

      expect(
        () => repo.getProfile(),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'message',
            'User not authenticated',
          ),
        ),
      );
    });

    test('returns the current user profile when the document exists', () async {
      when(() => authService.getCurrentUserId()).thenReturn('user_1');

      final doc = buildUserDoc({
        'userId': 'user_1',
        'name': 'Ali',
        'email': 'ali@example.com',
        'phoneNumber': '01012345678',
        'avatarUrl': 'https://example.com/avatar.png',
        'bio': 'Hello',
        'interests': ['Cameras', 'Gaming'],
        'verificationStatus': 'verified',
        'agreedToTerms': true,
        'createdAt': Timestamp.fromDate(DateTime(2026, 1, 1)),
      });

      when(
        () => usersService.getUserProfile(userId: 'user_1'),
      ).thenAnswer((_) async => doc);

      final result = await repo.getProfile();

      expect(result.userId, equals('user_1'));
      expect(result.name, equals('Ali'));
      expect(result.email, equals('ali@example.com'));
      expect(result.interests, equals(['Cameras', 'Gaming']));
    });

    test('uploadAvatar returns the uploaded url', () async {
      final imageFile = File('avatar.png');
      when(() => cloudinaryService.uploadImage(imageFile)).thenAnswer(
        (_) async => 'https://example.com/avatar.png',
      );

      final url = await repo.uploadAvatar(imageFile);

      expect(url, equals('https://example.com/avatar.png'));
    });

    test('uploadAvatar throws when upload fails to return a url', () async {
      final imageFile = File('avatar.png');
      when(() => cloudinaryService.uploadImage(imageFile)).thenAnswer(
        (_) async => null,
      );

      expect(
        () => repo.uploadAvatar(imageFile),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'message',
            'Failed to upload image',
          ),
        ),
      );
    });

    test('updateProfile sends only changed fields and reloads the profile',
        () async {
      when(() => authService.getCurrentUserId()).thenReturn('user_1');
      when(
        () => usersService.updateUserProfile(
          userId: 'user_1',
          updatedData: any(named: 'updatedData'),
        ),
      ).thenAnswer((_) async {});

      final updatedDoc = buildUserDoc({
        'userId': 'user_1',
        'name': 'New Name',
        'email': 'ali@example.com',
        'phoneNumber': '01111111111',
        'avatarUrl': 'https://example.com/new.png',
        'bio': 'Updated bio',
        'createdAt': Timestamp.fromDate(DateTime(2026, 1, 1)),
      });
      when(
        () => usersService.getUserProfile(userId: 'user_1'),
      ).thenAnswer((_) async => updatedDoc);

      final result = await repo.updateProfile(
        name: 'New Name',
        phoneNumber: '01111111111',
        bio: 'Updated bio',
        avatarUrl: 'https://example.com/new.png',
      );

      expect(result.name, equals('New Name'));
      expect(result.phoneNumber, equals('01111111111'));
      expect(result.bio, equals('Updated bio'));
      expect(result.avatarUrl, equals('https://example.com/new.png'));
      final captured = verify(
        () => usersService.updateUserProfile(
          userId: 'user_1',
          updatedData: captureAny(named: 'updatedData'),
        ),
      ).captured.single as Map<String, dynamic>;

      expect(captured['name'], equals('New Name'));
      expect(captured['phoneNumber'], equals('01111111111'));
      expect(captured['bio'], equals('Updated bio'));
      expect(captured['avatarUrl'], equals('https://example.com/new.png'));
      expect(captured, hasLength(4));
    });
  });
}
