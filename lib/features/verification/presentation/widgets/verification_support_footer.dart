import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class VerificationSupportFooter extends StatelessWidget {
  final VoidCallback onContactSupport;

  const VerificationSupportFooter({super.key, required this.onContactSupport});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onContactSupport,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: .symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          mainAxisSize: .min,
          mainAxisAlignment: .center,
          children: [
            Icon(
              Icons.headset_mic_rounded,
              size: 18.sp,
              color: AppColors.primaryColor,
            ),
            horizontalSpace(8),
            Text(
              "Need Help? ",
              style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: 13.sp,
                fontWeight: .w500,
              ),
            ),
            Text(
              "Contact Support",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 13.sp,
                fontWeight: .bold,
                decoration: .underline,
                decorationColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
