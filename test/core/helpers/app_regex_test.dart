import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/core/helpers/app_regex.dart';

void main() {
  group('AppRegex Tests', () {
    group('isEmailValid', () {
      test('should return true for valid email formats', () {
        expect(AppRegex.isEmailValid('test@example.com'), isTrue);
        expect(AppRegex.isEmailValid('user.name+tag@domain.co'), isTrue);
        expect(AppRegex.isEmailValid('admin123@sub.domain.org'), isTrue);
      });

      test('should return false for invalid email formats', () {
        expect(AppRegex.isEmailValid(''), isFalse);
        expect(AppRegex.isEmailValid('plainaddress'), isFalse);
        expect(AppRegex.isEmailValid('@missingusername.com'), isFalse);
        expect(AppRegex.isEmailValid('username@.com'), isFalse);
        expect(AppRegex.isEmailValid('user@domain'), isFalse);
        expect(AppRegex.isEmailValid('user@domain.c'), isFalse);
      });
    });

    group('isPasswordValid', () {
      test('should return true for strong password meeting all criteria', () {
        expect(AppRegex.isPasswordValid('StrongP@ss1'), isTrue);
        expect(AppRegex.isPasswordValid('Secure#123A'), isTrue);
      });

      test('should return false when criteria are missing', () {
        expect(AppRegex.isPasswordValid('weak'), isFalse); // too short
        expect(AppRegex.isPasswordValid('alllowercase1@'), isFalse); // no upper
        expect(AppRegex.isPasswordValid('ALLUPPERCASE1@'), isFalse); // no lower
        expect(
          AppRegex.isPasswordValid('NoSpecialChar1A'),
          isFalse,
        ); // no special char
        expect(
          AppRegex.isPasswordValid('NoNumbers!@#Aa'),
          isFalse,
        ); // no number
      });
    });

    group('isPhoneNumberValid', () {
      test('should return true for valid Egyptian mobile numbers', () {
        expect(AppRegex.isPhoneNumberValid('01012345678'), isTrue);
        expect(AppRegex.isPhoneNumberValid('01198765432'), isTrue);
        expect(AppRegex.isPhoneNumberValid('01234567890'), isTrue);
        expect(AppRegex.isPhoneNumberValid('01555555555'), isTrue);
      });

      test('should return false for invalid phone numbers', () {
        expect(AppRegex.isPhoneNumberValid(''), isFalse);
        expect(
          AppRegex.isPhoneNumberValid('01312345678'),
          isFalse,
        ); // invalid prefix
        expect(
          AppRegex.isPhoneNumberValid('0101234567'),
          isFalse,
        ); // 10 digits (too short)
        expect(
          AppRegex.isPhoneNumberValid('010123456789'),
          isFalse,
        ); // 12 digits (too long)
        expect(AppRegex.isPhoneNumberValid('abcdefghijk'), isFalse);
      });
    });

    group('Individual password helper checks', () {
      test('hasLowerCase', () {
        expect(AppRegex.hasLowerCase('abc'), isTrue);
        expect(AppRegex.hasLowerCase('ABC'), isFalse);
        expect(AppRegex.hasLowerCase('123'), isFalse);
      });

      test('hasUpperCase', () {
        expect(AppRegex.hasUpperCase('ABC'), isTrue);
        expect(AppRegex.hasUpperCase('abc'), isFalse);
        expect(AppRegex.hasUpperCase('123'), isFalse);
      });

      test('hasNumber', () {
        expect(AppRegex.hasNumber('pass1'), isTrue);
        expect(AppRegex.hasNumber('password'), isFalse);
      });

      test('hasSpecialCharacter', () {
        expect(AppRegex.hasSpecialCharacter('pass@'), isTrue);
        expect(AppRegex.hasSpecialCharacter('pass#'), isTrue);
        expect(AppRegex.hasSpecialCharacter('password'), isFalse);
      });

      test('hasMinLength', () {
        expect(AppRegex.hasMinLength('12345678'), isTrue);
        expect(AppRegex.hasMinLength('123456789'), isTrue);
        expect(AppRegex.hasMinLength('1234567'), isFalse);
      });
    });
  });
}
