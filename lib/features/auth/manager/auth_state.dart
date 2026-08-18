import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/auth/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final Failure failure;
  AuthError(this.failure);
}

class PasswordResetSent extends AuthState {
  final String email;
  PasswordResetSent(this.email);
}

class AuthSignedOut extends AuthState {}
