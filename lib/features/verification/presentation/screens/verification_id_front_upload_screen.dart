import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/verification/manager/verification_cubit.dart';
import 'package:rentora/features/verification/presentation/models/verification_route_args.dart';
import 'package:rentora/features/verification/presentation/widgets/id_upload_screen_content.dart';

class VerificationIdFrontUploadScreen extends StatefulWidget {
  const VerificationIdFrontUploadScreen({super.key});

  @override
  State<VerificationIdFrontUploadScreen> createState() =>
      _VerificationIdFrontUploadScreenState();
}

class _VerificationIdFrontUploadScreenState
    extends State<VerificationIdFrontUploadScreen> {
  bool _isPicking = false;

  Future<void> _pickFrontImage(ImageSource source) async {
    final cubit = context.read<VerificationCubit>();

    setState(() => _isPicking = true);
    await cubit.pickIdFrontImage(source);

    if (!mounted) return;

    if (cubit.idFrontFile == null) {
      setState(() => _isPicking = false);
      return;
    }

    await Future<void>.delayed(const Duration(milliseconds: 450));

    if (!mounted) return;

    setState(() => _isPicking = false);
    context.pushNamed(
      Routes.verificationIdBackUploadScreen,
      arguments: VerificationRouteArgs(verificationCubit: cubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<VerificationCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(text: "Account Verification"),
      body: IdUploadScreenContent(
        title: "Upload ID Front",
        subtitle:
            "Please take a clear and readable photo of your ID front side. Make sure there are no reflections and all corners are visible within the frame.",
        frameLabel: "Place front ID here",
        primaryText: _isPicking ? "Opening Camera" : "Take a Photo",
        secondaryText: "Upload from Gallery",
        imageFile: cubit.idFrontFile,
        onFrameTap: _isPicking
            ? null
            : () => _pickFrontImage(ImageSource.camera),
        onPrimaryPressed: _isPicking
            ? null
            : () => _pickFrontImage(ImageSource.camera),
        onSecondaryPressed: _isPicking
            ? null
            : () => _pickFrontImage(ImageSource.gallery),
        isLoading: _isPicking,
      ),
    );
  }
}
