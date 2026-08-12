import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class FirebaseErrorHandler {
  /// Main function that receives any error and returns a user-friendly message
  static String handle(dynamic error) {
    if (error is FirebaseAuthException) {
      return _handleFirebaseAuthError(error);
    } else if (error is FirebaseException) {
      return _handleFirebaseError(error);
    } else if (error is SocketException) {
      return "No internet connection. Please check your network and try again";
    } else if (error is TimeoutException) {
      return "Connection timed out. Please try again later";
    } else if (error is PlatformException) {
      return "Platform error: ${error.message}";
    } else if (error is FormatException) {
      return "Data processing error occurred.";
    } else {
      return "An unexpected error occurred. Please try again later";
    }
  }

  /// Handle Authentication Errors
  static String _handleFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case "invalid-email":
        return "Invalid email address format";
      case "user-disabled":
        return "This account has been disabled. Please contact support";
      case "user-not-found":
        return "No account found associated with this email";
      case "wrong-password":
        return "Incorrect password";
      case "email-already-in-use":
        return "This email is already in use by another account";
      case "weak-password":
        return "Password is too weak. Please choose a stronger password";
      case "network-request-failed":
        return "Please check your internet connection";
      case "too-many-requests":
        return "Account temporarily blocked due to multiple failed attempts. Please try again later";
      case "requires-recent-login":
        return "Please log in again to complete this action";
      default:
        return "An authentication error occurred. Please try again later";
    }
  }

  /// Handle Database Errors (Firestore & Storage)
  static String _handleFirebaseError(FirebaseException error) {
    switch (error.code) {
      case "permission-denied":
        return "You do not have permission to perform this action";
      case "unavailable":
        return "Service is currently unavailable. Please check your internet connection";
      case "not-found":
        return "The requested data could not be found";
      case "already-exists":
        return "This data already exists";
      case "cancelled":
        return "The operation was cancelled";
      case "deadline-exceeded":
        return "The request took too long. Please try again";
      default:
        return "A server connection error occurred.";
    }
  }
}

// Example for using this File
// try {
//   FireBase Code Here
// } on FirebaseAuthException catch (e) {
//   return ServerFailure(FirebaseErrorHandler.handleAuthError(e));
// } catch (e) {
//   return ServerFailure(e.toString());
// }
