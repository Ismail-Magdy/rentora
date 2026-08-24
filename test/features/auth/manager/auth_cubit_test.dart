import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/exceptions.dart';
import 'package:rentora/features/auth/data/models/user_model.dart';
import 'package:rentora/features/auth/data/repos/auth_repo.dart';
import 'package:rentora/features/auth/manager/auth_cubit.dart';
import 'package:rentora/features/auth/manager/auth_state.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late MockAuthRepo repo;
  final user = UserModel(
    userId: 'u1',
    name: 'Ali',
    email: 'a@b.com',
    phoneNumber: '010',
    createdAt: DateTime(2026),
  );
  setUp(() => repo = MockAuthRepo());

  blocTest<AuthCubit, AuthState>(
    'login emits loading then success',
    build: () {
      when(
        () => repo.login(email: 'a@b.com', password: 'Password1!'),
      ).thenAnswer((_) async => user);
      return AuthCubit(repo);
    },
    act: (c) => c.login(email: 'a@b.com', password: 'Password1!'),
    expect: () => [isA<AuthLoading>(), isA<AuthSuccess>()],
  );
  blocTest<AuthCubit, AuthState>(
    'login maps server exception to error',
    build: () {
      when(
        () => repo.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(const ServerException('invalid'));
      return AuthCubit(repo);
    },
    act: (c) => c.login(email: 'x', password: 'y'),
    expect: () => [isA<AuthLoading>(), isA<AuthError>()],
  );
  blocTest<AuthCubit, AuthState>(
    'reset emits PasswordResetSent',
    build: () {
      when(
        () => repo.sendPasswordReset(email: 'a@b.com'),
      ).thenAnswer((_) async {});
      return AuthCubit(repo);
    },
    act: (c) => c.sendPasswordReset(email: 'a@b.com'),
    expect: () => [isA<AuthLoading>(), isA<PasswordResetSent>()],
  );
  blocTest<AuthCubit, AuthState>(
    'sign out emits signed out',
    build: () {
      when(() => repo.signOut()).thenAnswer((_) async {});
      return AuthCubit(repo);
    },
    act: (c) => c.signOut(),
    expect: () => [isA<AuthSignedOut>()],
  );
}
