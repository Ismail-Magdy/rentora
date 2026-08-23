import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/verification/manager/verification_cubit.dart';
import 'package:rentora/features/verification/presentation/widgets/id_upload_screen_content.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<VerificationCubit, VerificationState>(
      listener: (context, state) {
        if (state is VerificationError) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline,
            color: AppColors.error,
            title: l10n.error,
            message: state.message,
          );
        } else if (state is VerificationSuccess) {
          context.pushNamedAndRemoveUntil(
            Routes.verificationPendingScreen,
            predicate: (route) => false,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<VerificationCubit>();
        final hasBackImage = cubit.idBackFile != null;

        final isLoading = state is VerificationLoading || _isPicking;

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(text: l10n.verificationAppBarTitle),
          body: IdUploadScreenContent(
            title: l10n.uploadIdBack,
            subtitle: l10n.uploadIdBackSubtitle,
            frameLabel: l10n.placeBackIdHere,
            primaryText: hasBackImage ? l10n.submitDocuments : l10n.takePhoto,
            secondaryText: hasBackImage
                ? l10n.retakeFromGallery
                : l10n.uploadPhoto,
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
      },
    );
  }
}
