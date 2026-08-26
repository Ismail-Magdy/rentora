import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/exceptions.dart';
import 'package:rentora/features/auth/data/models/user_model.dart';
import 'package:rentora/features/profile/data/repo/profile_repo.dart';
import 'package:rentora/features/profile/manager/profile_cubit.dart';
import 'package:rentora/features/profile/manager/profile_state.dart';

class MockProfileRepo extends Mock implements ProfileRepo {}

void main() {
  late MockProfileRepo repo;
  late UserModel user;
  final avatarFile = File('avatar.png');

  setUp(() {
    repo = MockProfileRepo();
    user = UserModel(
      userId: 'user_1',
      name: 'Ali',
      email: 'ali@example.com',
      phoneNumber: '01012345678',
      bio: 'Hello',
      avatarUrl: 'https://example.com/avatar.png',
      createdAt: DateTime(2026, 1, 1),
    );
  });

  group('ProfileCubit', () {
    blocTest<ProfileCubit, ProfileState>(
      'loadProfile emits loading then loaded when the repository succeeds',
      build: () {
        when(() => repo.getProfile()).thenAnswer((_) async => user);
        return ProfileCubit(repo);
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        isA<ProfileLoading>(),
        predicate<ProfileState>((state) {
          final loaded = state as ProfileLoaded;
          return loaded.user == user;
        }),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'loadProfile emits an error when the repository throws',
      build: () {
        when(() => repo.getProfile()).thenThrow(const ServerException('boom'));
        return ProfileCubit(repo);
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        isA<ProfileLoading>(),
        predicate<ProfileState>(
          (state) => state is ProfileError && state.message == 'boom',
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'saveProfile updates without uploading an avatar when no file is given',
      build: () {
        when(
          () => repo.updateProfile(
            name: 'Ali Updated',
            phoneNumber: '01111111111',
            bio: 'New bio',
            avatarUrl: null,
          ),
        ).thenAnswer(
          (_) async => UserModel(
            userId: 'user_1',
            name: 'Ali Updated',
            email: 'ali@example.com',
            phoneNumber: '01111111111',
            bio: 'New bio',
            createdAt: DateTime(2026, 1, 1),
          ),
        );
        return ProfileCubit(repo);
      },
      act: (cubit) => cubit.saveProfile(
        name: 'Ali Updated',
        phoneNumber: '01111111111',
        bio: 'New bio',
      ),
      expect: () => [
        isA<ProfileUpdating>(),
        predicate<ProfileState>(
          (state) =>
              state is ProfileUpdated &&
              state.user.name == 'Ali Updated' &&
              state.user.phoneNumber == '01111111111',
        ),
      ],
      verify: (_) {
        verifyNever(() => repo.uploadAvatar(avatarFile));
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'saveProfile uploads an avatar before updating the profile',
      build: () {
        when(() => repo.uploadAvatar(avatarFile)).thenAnswer(
          (_) async => 'https://example.com/new-avatar.png',
        );
        when(
          () => repo.updateProfile(
            name: 'Ali Updated',
            phoneNumber: '01111111111',
            bio: 'New bio',
            avatarUrl: 'https://example.com/new-avatar.png',
          ),
        ).thenAnswer(
          (_) async => UserModel(
            userId: 'user_1',
            name: 'Ali Updated',
            email: 'ali@example.com',
            phoneNumber: '01111111111',
            bio: 'New bio',
            avatarUrl: 'https://example.com/new-avatar.png',
            createdAt: DateTime(2026, 1, 1),
          ),
        );
        return ProfileCubit(repo);
      },
      act: (cubit) => cubit.saveProfile(
        name: 'Ali Updated',
        phoneNumber: '01111111111',
        bio: 'New bio',
        avatarFile: avatarFile,
      ),
      expect: () => [
        isA<ProfileUpdating>(),
        predicate<ProfileState>(
          (state) =>
              state is ProfileUpdated &&
              state.user.avatarUrl == 'https://example.com/new-avatar.png',
        ),
      ],
    );
  });
}
