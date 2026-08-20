import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rentora/core/errors/exceptions.dart';
import 'package:rentora/core/errors/firebase_error_handler.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/core/network/firebase/users_firestore_service.dart';
import 'package:rentora/features/auth/data/models/user_model.dart';

class AuthRepo {
  final FirebaseAuthService _authService;
  final UsersFirestoreService _usersService;

  AuthRepo({
    required FirebaseAuthService authService,
    required UsersFirestoreService usersService,
  }) : _authService = authService,
       _usersService = usersService;

  Future<void> _checkConnection() async {
    final hasConnection = await InternetConnection().hasInternetAccess;
    if (!hasConnection) {
      throw const OfflineException("No internet connection");
    }
  }

  Future<UserModel> signInWithGoogle() async {
    await _checkConnection();
    try {
      final credential = await _authService.signInWithGoogle();

      final userDoc = await _usersService.getUserProfile(
        userId: credential.user!.uid,
      );

      if (userDoc.exists) {
        return UserModel.fromFirestore(userDoc);
      } else {
        final newUser = UserModel(
          userId: credential.user!.uid,
          name: credential.user!.displayName ?? 'Google User',
          email: credential.user!.email ?? '',
          phoneNumber: credential.user!.phoneNumber ?? '',
          avatarUrl: credential.user!.photoURL,
          agreedToTerms: true,
          createdAt: DateTime.now(),
        );

        await _usersService.createUserProfile(
          userId: newUser.userId,
          userData: newUser.toFirestore(),
        );
        return newUser;
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(FirebaseErrorHandler.handle(e));
    } on SocketException {
      throw const OfflineException("No internet connection");
    } catch (e) {
      throw ServerException(FirebaseErrorHandler.handle(e));
    }
  }

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required bool agreedToTerms,
  }) async {
    await _checkConnection();
    try {
      final credential = await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        userId: credential.user!.uid,
        name: name.trim(),
        email: email.trim(),
        phoneNumber: phoneNumber.trim(),
        agreedToTerms: agreedToTerms,
        createdAt: DateTime.now(),
      );

      await _usersService.createUserProfile(
        userId: user.userId,
        userData: user.toFirestore(),
      );

      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(FirebaseErrorHandler.handle(e));
    } on SocketException {
      throw const OfflineException("No internet connection");
    } catch (e) {
      throw ServerException(FirebaseErrorHandler.handle(e));
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await _checkConnection();
    try {
      final credential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userDoc = await _usersService.getUserProfile(
        userId: credential.user!.uid,
      );

      if (!userDoc.exists) {
        throw const ServerException("User profile not found in database");
      }

      return UserModel.fromFirestore(userDoc);
    } on FirebaseAuthException catch (e) {
      throw ServerException(FirebaseErrorHandler.handle(e));
    } on SocketException {
      throw const OfflineException("No internet connection");
    } catch (e) {
      throw ServerException(FirebaseErrorHandler.handle(e));
    }
  }

  Future<void> sendPasswordReset({required String email}) async {
    await _checkConnection();
    try {
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email.trim())
          .get();

      if (userQuery.docs.isEmpty) {
        throw const ServerException("No account found with this email address");
      }

      await _authService.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(FirebaseErrorHandler.handle(e));
    } on SocketException {
      throw const OfflineException("No internet connection");
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(FirebaseErrorHandler.handle(e));
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
