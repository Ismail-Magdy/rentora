import 'package:cloud_firestore/cloud_firestore.dart';

class VerificationModel {
  final String verificationId;
  final String selfieUrl;
  final String idFrontUrl;
  final String idBackUrl;
  final String status;
  final Timestamp? submittedAt;

  VerificationModel({
    required this.verificationId,
    required this.selfieUrl,
    required this.idFrontUrl,
    required this.idBackUrl,
    required this.status,
    this.submittedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'verificationId': verificationId,
      'selfieUrl': selfieUrl,
      'idFrontUrl': idFrontUrl,
      'idBackUrl': idBackUrl,
      'status': status,
      'submittedAt': submittedAt ?? FieldValue.serverTimestamp(),
    };
  }

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      verificationId: json['verificationId'] ?? '',
      selfieUrl: json['selfieUrl'] ?? '',
      idFrontUrl: json['idFrontUrl'] ?? '',
      idBackUrl: json['idBackUrl'] ?? '',
      status: json['status'] ?? 'pending',
      submittedAt: json['submittedAt'],
    );
  }
}
