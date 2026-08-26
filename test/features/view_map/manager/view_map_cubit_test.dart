import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/home/data/repos/home_repo.dart';
import 'package:rentora/features/view_map/manager/view_map_cubit.dart';
import 'package:rentora/features/view_map/manager/view_map_state.dart';

class MockHomeRepo extends Mock implements HomeRepo {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// ignore: subtype_of_sealed_class
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late MockHomeRepo mockHomeRepo;
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    when(() => mockAuth.currentUser).thenReturn(null);
  });

  group('ViewMapCubit Tests', () {
    blocTest<ViewMapCubit, ViewMapState>(
      'emits ViewMapError when getProducts fails',
      build: () {
        when(
          () => mockHomeRepo.getProducts(),
        ).thenAnswer((_) async => Left(ServerFailure('Failed to fetch')));
        when(
          () => mockHomeRepo.getUserLocation(),
        ).thenAnswer((_) async => const Right(null));
        return ViewMapCubit(
          mockHomeRepo,
          auth: mockAuth,
          firestore: mockFirestore,
        );
      },
      act: (cubit) => cubit.getViewMapData(),
      expect: () => [isA<ViewMapLoading>(), isA<ViewMapError>()],
    );
  });
}
