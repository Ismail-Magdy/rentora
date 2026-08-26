import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/core/errors/firebase_error_handler.dart';

void main() {
  group('FirebaseErrorHandler', () {
    test('maps FirebaseAuthException codes to user-friendly messages', () {
      expect(
        FirebaseErrorHandler.handle(
          FirebaseAuthException(code: 'invalid-email', message: 'bad email'),
        ),
        equals('Invalid email address format'),
      );
      expect(
        FirebaseErrorHandler.handle(
          FirebaseAuthException(
            code: 'email-already-in-use',
            message: 'already used',
          ),
        ),
        equals('This email is already in use by another account'),
      );
      expect(
        FirebaseErrorHandler.handle(
          FirebaseAuthException(code: 'weak-password', message: 'weak'),
        ),
        equals('Password is too weak. Please choose a stronger password'),
      );
    });

    test('maps FirebaseException codes to user-friendly messages', () {
      expect(
        FirebaseErrorHandler.handle(
          FirebaseException(
            plugin: 'firestore',
            code: 'permission-denied',
            message: 'Denied',
          ),
        ),
        equals('You do not have permission to perform this action'),
      );
      expect(
        FirebaseErrorHandler.handle(
          FirebaseException(
            plugin: 'firestore',
            code: 'not-found',
            message: 'Missing',
          ),
        ),
        equals('The requested data could not be found'),
      );
      expect(
        FirebaseErrorHandler.handle(
          FirebaseException(
            plugin: 'firestore',
            code: 'deadline-exceeded',
            message: 'Slow',
          ),
        ),
        equals('The request took too long. Please try again'),
      );
    });

    test('maps common non-Firebase exceptions', () {
      expect(
        FirebaseErrorHandler.handle(SocketException('offline')),
        equals(
          'No internet connection. Please check your network and try again',
        ),
      );
      expect(
        FirebaseErrorHandler.handle(TimeoutException('timed out')),
        equals('Connection timed out. Please try again later'),
      );
      expect(
        FirebaseErrorHandler.handle(
          PlatformException(code: 'platform', message: 'boom'),
        ),
        equals('Platform error: boom'),
      );
      expect(
        FirebaseErrorHandler.handle(const FormatException('bad format')),
        equals('Data processing error occurred.'),
      );
      expect(
        FirebaseErrorHandler.handle(Exception('unknown')),
        equals('An unexpected error occurred. Please try again later'),
      );
    });
  });
}
