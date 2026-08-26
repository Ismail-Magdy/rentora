import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/verification/data/model/verification_model.dart';

void main() {
  group('VerificationModel Tests', () {
    test('serializes to and from Json accurately', () {
      final now = Timestamp.now();
      final model = VerificationModel(
        verificationId: 'v_123',
        selfieUrl: 'https://img.com/selfie.jpg',
        idFrontUrl: 'https://img.com/front.jpg',
        idBackUrl: 'https://img.com/back.jpg',
        status: 'pending',
        submittedAt: now,
      );

      final json = model.toJson();
      expect(json['verificationId'], 'v_123');
      expect(json['selfieUrl'], 'https://img.com/selfie.jpg');
      expect(json['idFrontUrl'], 'https://img.com/front.jpg');
      expect(json['idBackUrl'], 'https://img.com/back.jpg');
      expect(json['status'], 'pending');

      final fromJson = VerificationModel.fromJson(json);
      expect(fromJson.verificationId, 'v_123');
      expect(fromJson.selfieUrl, 'https://img.com/selfie.jpg');
      expect(fromJson.idFrontUrl, 'https://img.com/front.jpg');
      expect(fromJson.idBackUrl, 'https://img.com/back.jpg');
      expect(fromJson.status, 'pending');
      expect(fromJson.submittedAt, now);
    });

    test('fromJson handles null/default values gracefully', () {
      final model = VerificationModel.fromJson({});
      expect(model.verificationId, '');
      expect(model.selfieUrl, '');
      expect(model.idFrontUrl, '');
      expect(model.idBackUrl, '');
      expect(model.status, 'pending');
      expect(model.submittedAt, isNull);
    });
  });
}
