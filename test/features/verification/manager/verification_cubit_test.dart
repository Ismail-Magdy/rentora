import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/features/verification/data/repo/verification_repo.dart';
import 'package:rentora/features/verification/manager/verification_cubit.dart';

class MockVerificationRepo extends Mock implements VerificationRepo {}

class MockFirebaseAuthService extends Mock implements FirebaseAuthService {}

void main() {
  late MockVerificationRepo mockRepo;
  late MockFirebaseAuthService mockAuthService;

  setUpAll(() {
    registerFallbackValue(File('dummy'));
  });

  setUp(() {
    mockRepo = MockVerificationRepo();
    mockAuthService = MockFirebaseAuthService();
  });

  group('VerificationCubit Tests', () {
    blocTest<VerificationCubit, VerificationState>(
      'emits error when photos are missing on submit',
      build: () => VerificationCubit(mockRepo, mockAuthService),
      act: (cubit) => cubit.submitVerification(),
      expect: () => [isA<VerificationError>()],
    );

    blocTest<VerificationCubit, VerificationState>(
      'emits error when user is not logged in',
      build: () {
        when(() => mockAuthService.getCurrentUserId()).thenReturn(null);
        final cubit = VerificationCubit(mockRepo, mockAuthService);
        cubit.selfieFile = File('selfie.png');
        cubit.idFrontFile = File('front.png');
        cubit.idBackFile = File('back.png');
        return cubit;
      },
      act: (cubit) => cubit.submitVerification(),
      expect: () => [isA<VerificationError>()],
    );

    blocTest<VerificationCubit, VerificationState>(
      'submits verification successfully when files and user exist',
      build: () {
        when(() => mockAuthService.getCurrentUserId()).thenReturn('user_123');
        when(
          () => mockRepo.submitVerification(
            userId: any(named: 'userId'),
            selfieFile: any(named: 'selfieFile'),
            idFrontFile: any(named: 'idFrontFile'),
            idBackFile: any(named: 'idBackFile'),
          ),
        ).thenAnswer((_) async {});

        final cubit = VerificationCubit(mockRepo, mockAuthService);
        cubit.selfieFile = File('selfie.png');
        cubit.idFrontFile = File('front.png');
        cubit.idBackFile = File('back.png');
        return cubit;
      },
      act: (cubit) => cubit.submitVerification(),
      expect: () => [isA<VerificationLoading>(), isA<VerificationSuccess>()],
    );

    blocTest<VerificationCubit, VerificationState>(
      'emits error when submission fails',
      build: () {
        when(() => mockAuthService.getCurrentUserId()).thenReturn('user_123');
        when(
          () => mockRepo.submitVerification(
            userId: any(named: 'userId'),
            selfieFile: any(named: 'selfieFile'),
            idFrontFile: any(named: 'idFrontFile'),
            idBackFile: any(named: 'idBackFile'),
          ),
        ).thenThrow(ServerFailure('Upload failed'));

        final cubit = VerificationCubit(mockRepo, mockAuthService);
        cubit.selfieFile = File('selfie.png');
        cubit.idFrontFile = File('front.png');
        cubit.idBackFile = File('back.png');
        return cubit;
      },
      act: (cubit) => cubit.submitVerification(),
      expect: () => [isA<VerificationLoading>(), isA<VerificationError>()],
    );
  });
}
