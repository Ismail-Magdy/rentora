import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/core/errors/firebase_error_handler.dart';
import 'package:rentora/core/network/firebase/cloudinary_service.dart';
import 'package:rentora/core/network/firebase/verifications_firestore_service.dart';
import 'package:rentora/features/verification/data/model/verification_model.dart';

class VerificationRepo {
  final CloudinaryService _cloudinaryService;
  final VerificationsFirestoreService _verificationsFirestoreService;
  final FirebaseFirestore _firestore;

  VerificationRepo(
    this._cloudinaryService,
    this._verificationsFirestoreService,
    this._firestore,
  );

  Future<void> submitVerification({
    required String userId,
    required File selfieFile,
    required File idFrontFile,
    required File idBackFile,
  }) async {
    try {
      final uploadResults = await Future.wait([
        _cloudinaryService.uploadImage(selfieFile),
        _cloudinaryService.uploadImage(idFrontFile),
        _cloudinaryService.uploadImage(idBackFile),
      ]);

      final String? selfieUrl = uploadResults[0];
      final String? idFrontUrl = uploadResults[1];
      final String? idBackUrl = uploadResults[2];

      if (selfieUrl == null || idFrontUrl == null || idBackUrl == null) {
        throw const ServerFailure(
          "Failed to upload verification images, make sure you're connected to the internet and try again.",
        );
      }

      final verificationModel = VerificationModel(
        verificationId: userId,
        selfieUrl: selfieUrl,
        idFrontUrl: idFrontUrl,
        idBackUrl: idBackUrl,
        status: 'pending',
      );

      await _verificationsFirestoreService.submitVerification(
        userId: userId,
        verificationData: verificationModel.toJson(),
      );

      await _firestore.collection('users').doc(userId).update({
        'verificationStatus': 'pending',
      });
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      if (e is FirebaseException) {
        throw ServerFailure(FirebaseErrorHandler.handle(e));
      }
      throw ServerFailure(e.toString().replaceAll("Exception: ", ""));
    }
  }
}
