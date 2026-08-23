import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/verification/manager/verification_cubit.dart';
import 'package:rentora/features/verification/data/model/verification_route_args.dart';
import 'package:rentora/features/verification/presentation/widgets/id_upload_screen_content.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.watch<VerificationCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(text: l10n.verificationAppBarTitle),
      body: IdUploadScreenContent(
        title: l10n.uploadIdFront,
        subtitle: l10n.uploadIdFrontSubtitle,
        frameLabel: l10n.placeFrontIdHere,
        primaryText: _isPicking ? l10n.openingCamera : l10n.takePhoto,
        secondaryText: l10n.uploadPhoto,
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
