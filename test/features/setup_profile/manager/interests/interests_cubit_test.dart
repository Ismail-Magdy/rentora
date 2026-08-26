import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/setup_profile/data/repos/setup_profile_repo.dart';
import 'package:rentora/features/setup_profile/manager/interests/interests_cubit.dart';

class MockSetupProfileRepo extends Mock implements SetupProfileRepo {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() {
  late MockSetupProfileRepo repo;
  late MockFirebaseAuth auth;
  late MockUser user;
  final selectedTwoInterests = ['Cameras', 'Gaming'];
  final selectedOneInterest = ['Cameras'];

  setUpAll(() {
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    repo = MockSetupProfileRepo();
    auth = MockFirebaseAuth();
    user = MockUser();
    when(() => auth.currentUser).thenReturn(user);
    when(() => user.uid).thenReturn('user_1');
  });

  group('InterestsCubit', () {
    test('toggleInterest adds and removes an interest', () {
      final cubit = InterestsCubit(repo, auth);

      cubit.toggleInterest('Cameras');
      expect(cubit.selectedInterests, equals(['Cameras']));
      expect(cubit.state, isA<InterestsUpdated>());

      cubit.toggleInterest('Cameras');
      expect(cubit.selectedInterests, isEmpty);
      expect(cubit.state, isA<InterestsUpdated>());

      cubit.close();
    });

    blocTest<InterestsCubit, InterestsState>(
      'saveInterests emits an error when no interests are selected',
      build: () => InterestsCubit(repo, auth),
      act: (cubit) => cubit.saveInterests(),
      expect: () => [
        predicate<InterestsState>(
          (state) =>
              state is InterestsError &&
              (state).error == 'Please select at least one interest.',
        ),
      ],
    );

    blocTest<InterestsCubit, InterestsState>(
      'saveInterests emits saving then error when the user is missing',
      setUp: () {
        when(() => auth.currentUser).thenReturn(null);
      },
      build: () {
        final cubit = InterestsCubit(repo, auth);
        cubit.selectedInterests = ['Cameras'];
        return cubit;
      },
      act: (cubit) => cubit.saveInterests(),
      expect: () => [
        isA<InterestsSaving>(),
        predicate<InterestsState>(
          (state) =>
              state is InterestsError &&
              (state).error == 'User authentication error. Please login again',
        ),
      ],
    );

    blocTest<InterestsCubit, InterestsState>(
      'saveInterests emits success when the repository succeeds',
      setUp: () {
        when(
          () => repo.saveUserInterests(
            userId: 'user_1',
            interests: any(named: 'interests'),
          ),
        ).thenAnswer((_) async => const Right(null));
      },
      build: () {
        final cubit = InterestsCubit(repo, auth);
        cubit.selectedInterests = selectedTwoInterests;
        return cubit;
      },
      act: (cubit) => cubit.saveInterests(),
      expect: () => [isA<InterestsSaving>(), isA<InterestsSavedSuccess>()],
    );

    blocTest<InterestsCubit, InterestsState>(
      'saveInterests maps repository failures to error states',
      setUp: () {
        when(
          () => repo.saveUserInterests(
            userId: 'user_1',
            interests: any(named: 'interests'),
          ),
        ).thenAnswer((_) async => const Left(ServerFailure('Nope')));
      },
      build: () {
        final cubit = InterestsCubit(repo, auth);
        cubit.selectedInterests = selectedOneInterest;
        return cubit;
      },
      act: (cubit) => cubit.saveInterests(),
      expect: () => [
        isA<InterestsSaving>(),
        predicate<InterestsState>(
          (state) => state is InterestsError && (state).error == 'Nope',
        ),
      ],
    );
  });
}
