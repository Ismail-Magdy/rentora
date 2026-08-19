import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/errors/exceptions.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/auth/data/repos/auth_repo.dart';
import 'package:rentora/features/auth/manager/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required bool agreedToTerms,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _authRepo.signUp(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        agreedToTerms: agreedToTerms,
      );
      emit(AuthSuccess(user));
    } on ServerException catch (e) {
      emit(AuthError(ServerFailure(e.message)));
    } on OfflineException catch (e) {
      emit(AuthError(OfflineFailure(e.message)));
    } catch (e) {
      emit(AuthError(ServerFailure(e.toString())));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final user = await _authRepo.signInWithGoogle();
      emit(AuthSuccess(user));
    } on ServerException catch (e) {
      emit(AuthError(ServerFailure(e.message)));
    } on OfflineException catch (e) {
      emit(AuthError(OfflineFailure(e.message)));
    } catch (e) {
      emit(AuthError(ServerFailure(e.toString())));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await _authRepo.login(email: email, password: password);
      emit(AuthSuccess(user));
    } on ServerException catch (e) {
      emit(AuthError(ServerFailure(e.message)));
    } on OfflineException catch (e) {
      emit(AuthError(OfflineFailure(e.message)));
    } catch (e) {
      emit(AuthError(ServerFailure(e.toString())));
    }
  }

  Future<void> sendPasswordReset({required String email}) async {
    emit(AuthLoading());
    try {
      await _authRepo.sendPasswordReset(email: email);
      emit(PasswordResetSent(email));
    } on ServerException catch (e) {
      emit(AuthError(ServerFailure(e.message)));
    } on OfflineException catch (e) {
      emit(AuthError(OfflineFailure(e.message)));
    } catch (e) {
      emit(AuthError(ServerFailure(e.toString())));
    }
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
    emit(AuthSignedOut());
  }
}
