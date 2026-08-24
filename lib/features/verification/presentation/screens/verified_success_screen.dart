import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';

class VerifiedSuccessScreen extends StatelessWidget {
  const VerifiedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.successDark : AppColors.successLight).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified_rounded,
                  color: isDark ? Colors.greenAccent : AppColors.successDark,
                  size: 100.sp,
                ),
              ),
              verticalSpace(32),
              Text(
                'You are fully verified!',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(16),
              Text(
                'Your account has been successfully verified. You can now access all features in Rentora.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.darkGrey,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                text: 'Back to Settings',
                onPressed: () {
                  context.pop();
                },
                width: double.infinity,
                height: 52.h,
                fontSize: 16.sp,
                borderRadius: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
