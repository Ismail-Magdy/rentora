import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/features/verification/presentation/widgets/id_upload_frame.dart';
import 'package:rentora/features/verification/presentation/widgets/verification_footer_security.dart';
import 'package:rentora/features/verification/presentation/widgets/verification_screen_header.dart';
import 'package:rentora/features/verification/presentation/widgets/verification_upload_actions.dart';

class IdUploadScreenContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String frameLabel;
  final String primaryText;
  final String secondaryText;
  final File? imageFile;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final VoidCallback? onFrameTap;
  final bool isLoading;

  const IdUploadScreenContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.frameLabel,
    required this.primaryText,
    required this.secondaryText,
    required this.imageFile,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    this.onFrameTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerificationScreenHeader(
                  title: title,
                  subtitle: subtitle,
                  textAlign: TextAlign.left,
                ),
                verticalSpace(16),
                IdUploadFrame(
                  imageFile: imageFile,
                  onTap: onFrameTap ?? onPrimaryPressed ?? () {},
                  label: frameLabel,
                ),
                verticalSpace(10),
                const VerificationFooterSecurity(
                  text: "Your data is encrypted and securely protected.",
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            bottom: 28.h,
            top: 8.h,
          ),
          child: VerificationUploadActions(
            primaryText: primaryText,
            secondaryText: secondaryText,
            primaryIcon: imageFile != null
                ? Icons.check_circle_rounded
                : Icons.camera_alt_rounded,
            secondaryIcon: Icons.photo_library_rounded,
            onPrimaryPressed: onPrimaryPressed,
            onSecondaryPressed: onSecondaryPressed,
            isLoading: isLoading,
          ),
        ),
      ],
    );
  }
}
