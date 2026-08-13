import 'package:cloud_firestore/cloud_firestore.dart';

class VerificationsFirestoreService {
  final FirebaseFirestore _firestore;

  VerificationsFirestoreService(this._firestore);

  /// Submits the user's verification documents (Selfie & ID URLs)
  /// The document ID is the same as the userId for strict one-to-one mapping
  Future<void> submitVerification({
    required String userId,
    required Map<String, dynamic> verificationData,
  }) async {
    await _firestore
        .collection("verifications")
        .doc(userId)
        .set(verificationData);
  }

  /// Checks the current verification status for a specific user
  Future<DocumentSnapshot<Map<String, dynamic>>> getVerificationStatus({
    required String userId,
  }) async {
    return await _firestore.collection("verifications").doc(userId).get();
  }

  /* 
  CLASS SUMMARY:
  This class isolates the highly sensitive Identity Verification data from 
  the standard user profile. It is solely responsible for uploading ID links 
  and checking if a user has been verified by the Rentora administration team
  */
}
