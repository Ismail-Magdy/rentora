import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';

class VerificationUploadActions extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final bool isLoading;
  final IconData primaryIcon;
  final IconData secondaryIcon;

  const VerificationUploadActions({
    super.key,
    required this.primaryText,
    required this.secondaryText,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    this.isLoading = false,
    this.primaryIcon = Icons.camera_alt_rounded,
    this.secondaryIcon = Icons.photo_library_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomButton(
          text: primaryText,
          icon: primaryIcon,
          onPressed: onPrimaryPressed,
          height: 50.h,
          borderRadius: 14.r,
          color: AppColors.primaryColor,
          fontSize: 15.sp,
          isLoading: isLoading,
        ),
        verticalSpace(12),
        CustomButton(
          text: secondaryText,
          icon: secondaryIcon,
          onPressed: isLoading ? null : onSecondaryPressed,
          height: 50.h,
          borderRadius: 14.r,
          color: AppColors.white,
          textColor: AppColors.primaryColor,
          borderColor: AppColors.primaryColor,
          fontSize: 15.sp,
        ),
      ],
    );
  }
}
