part of 'verification_cubit.dart';

abstract class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationImagePicked extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationSuccess extends VerificationState {}

class VerificationError extends VerificationState {
  final String message;
  VerificationError(this.message);
}
