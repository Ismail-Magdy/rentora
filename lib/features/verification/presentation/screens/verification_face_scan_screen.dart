import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/verification/manager/verification_cubit.dart';
import 'package:rentora/features/verification/data/model/verification_route_args.dart';
import 'package:rentora/features/verification/presentation/widgets/face_scan_screen_content.dart';

class VerificationFaceScanScreen extends StatefulWidget {
  const VerificationFaceScanScreen({super.key});

  @override
  State<VerificationFaceScanScreen> createState() =>
      _VerificationFaceScanScreenState();
}

class _VerificationFaceScanScreenState
    extends State<VerificationFaceScanScreen> {
  bool _isVerifying = false;

  Future<void> _takeSelfie() async {
    final cubit = context.read<VerificationCubit>();

    setState(() => _isVerifying = true);
    await cubit.pickSelfieImage(ImageSource.camera);

    if (!mounted) return;

    if (cubit.selfieFile == null) {
      setState(() => _isVerifying = false);
      return;
    }

    await Future<void>.delayed(const Duration(milliseconds: 650));

    if (!mounted) return;

    setState(() => _isVerifying = false);
    context.pushNamed(
      Routes.verificationIdFrontUploadScreen,
      arguments: VerificationRouteArgs(verificationCubit: cubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<VerificationCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(text: "Account verification"),
      body: FaceScanScreenContent(
        selfieFile: cubit.selfieFile,
        onTakeSelfie: _isVerifying ? () {} : _takeSelfie,
        isVerifying: _isVerifying,
      ),
    );
  }
}
