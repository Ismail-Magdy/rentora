import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/verification/manager/verification_cubit.dart';
import 'package:rentora/features/verification/presentation/widgets/id_upload_screen_content.dart';

class VerificationIdBackUploadScreen extends StatefulWidget {
  const VerificationIdBackUploadScreen({super.key});

  @override
  State<VerificationIdBackUploadScreen> createState() =>
      _VerificationIdBackUploadScreenState();
}

class _VerificationIdBackUploadScreenState
    extends State<VerificationIdBackUploadScreen> {
  bool _isPicking = false;

  Future<void> _pickBackImage(ImageSource source) async {
    final cubit = context.read<VerificationCubit>();

    setState(() => _isPicking = true);
    await cubit.pickIdBackImage(source);

    if (!mounted) return;
    setState(() => _isPicking = false);
  }

  void _submitDocuments() {
    context.read<VerificationCubit>().submitVerification();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<VerificationCubit>();
    final state = cubit.state;
    final hasBackImage = cubit.idBackFile != null;
    final isLoading = state is VerificationLoading || _isPicking;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(text: "Account Verification"),
      body: IdUploadScreenContent(
        title: "Upload ID Back",
        subtitle:
            "Please take a clear and readable photo of your ID back side. Make sure there are no reflections and all corners are visible within the frame.",
        frameLabel: "Place back ID here",
        primaryText: hasBackImage ? "Submit Documents" : "Take a Photo",
        secondaryText: hasBackImage
            ? "Retake from Gallery"
            : "Upload from Gallery",
        imageFile: cubit.idBackFile,
        onFrameTap: isLoading
            ? null
            : () => _pickBackImage(ImageSource.camera),
        onPrimaryPressed: isLoading
            ? null
            : hasBackImage
            ? _submitDocuments
            : () => _pickBackImage(ImageSource.camera),
        onSecondaryPressed: isLoading
            ? null
            : () => _pickBackImage(ImageSource.gallery),
        isLoading: isLoading,
      ),
    );
  }
}
