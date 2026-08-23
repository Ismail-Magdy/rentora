import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class VerificationSupportFooter extends StatelessWidget {
  final VoidCallback onContactSupport;

  const VerificationSupportFooter({super.key, required this.onContactSupport});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      onTap: onContactSupport,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.headset_mic_rounded,
              size: 18.sp,
              color: AppColors.primaryColor,
            ),
            horizontalSpace(8),
            Text(
              l10n.needHelp,
              style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              l10n.contactSupport,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
