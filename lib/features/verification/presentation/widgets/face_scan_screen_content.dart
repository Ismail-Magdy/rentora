import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/features/verification/presentation/widgets/face_scan_preview.dart';
import 'package:rentora/features/verification/presentation/widgets/verification_footer_security.dart';
import 'package:rentora/features/verification/presentation/widgets/verification_screen_header.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class FaceScanScreenContent extends StatelessWidget {
  final File? selfieFile;
  final VoidCallback onTakeSelfie;
  final bool isVerifying;

  const FaceScanScreenContent({
    super.key,
    required this.selfieFile,
    required this.onTakeSelfie,
    this.isVerifying = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            verticalSpace(62),
            VerificationScreenHeader(
              title: l10n.faceScan,
              subtitle: l10n.placeFaceCircle,
            ),
            verticalSpace(50),
            FaceScanPreview(
              imageFile: selfieFile,
              onTap: onTakeSelfie,
              isVerifying: isVerifying,
            ),
            const Spacer(),
            const VerificationFooterSecurity(),
            verticalSpace(18),
          ],
        ),
      ),
    );
  }
}
