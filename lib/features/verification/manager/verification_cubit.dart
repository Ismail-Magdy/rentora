import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/features/verification/data/repo/verification_repo.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final VerificationRepo _verificationRepo;
  final FirebaseAuthService _firebaseAuthService;
  final ImagePicker _picker = ImagePicker();

  VerificationCubit(this._verificationRepo, this._firebaseAuthService)
    : super(VerificationInitial());

  File? selfieFile;
  File? idFrontFile;
  File? idBackFile;

  Future<void> _pickImage(
    ImageSource source,
    void Function(File file) onPicked,
  ) async {
    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 85);
      if (picked != null) {
        onPicked(File(picked.path));
        emit(VerificationImagePicked());
      }
    } catch (e) {
      emit(
        VerificationError(
          "Couldn't open the ${source == ImageSource.camera ? 'camera' : 'gallery'}. Please check permissions and try again.",
        ),
      );
    }
  }

  Future<void> pickSelfieImage(ImageSource source) async {
    await _pickImage(source, (file) => selfieFile = file);
  }

  Future<void> pickIdFrontImage(ImageSource source) async {
    await _pickImage(source, (file) => idFrontFile = file);
  }

  Future<void> pickIdBackImage(ImageSource source) async {
    await _pickImage(source, (file) => idBackFile = file);
  }

  Future<void> submitVerification() async {
    if (selfieFile == null || idFrontFile == null || idBackFile == null) {
      emit(
        VerificationError(
          "Please attach all the required photos (selfie, ID front, ID back).",
        ),
      );
      return;
    }

    final userId = _firebaseAuthService.getCurrentUserId();
    if (userId == null || userId.isEmpty) {
      emit(VerificationError("Please log in again to verify your account."));
      return;
    }

    emit(VerificationLoading());

    try {
      await _verificationRepo.submitVerification(
        userId: userId,
        selfieFile: selfieFile!,
        idFrontFile: idFrontFile!,
        idBackFile: idBackFile!,
      );

      emit(VerificationSuccess());
    } catch (e) {
      String errorMessage = "An unexpected error occurred";
      if (e is Failure) {
        errorMessage = e.message;
      } else {
        errorMessage = e.toString().replaceAll("Exception: ", "");
      }
      emit(VerificationError(errorMessage));
    }
  }
}
