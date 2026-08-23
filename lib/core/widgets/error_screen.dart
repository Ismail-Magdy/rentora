import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:rentora/core/themes/app_colors.dart";
import "package:rentora/l10n/generated/app_localizations.dart";
import "../helpers/spacing.dart";

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: .symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/error.png",
                height: 300.h,
                width: 300.w,
              ),
            ),
            //
            verticalSpace(30),
            //
            Text(
              l10n.somethingWentWrong,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: .bold,
                color: AppColors.primaryColor,
              ),
            ),
            //
            verticalSpace(16),
            //
            Text(
              l10n.tryAgainLater,
              textAlign: .center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: .normal,
                color: AppColors.secondaryColor,
              ),
            ),
            //
            //
          ],
        ),
      ),
    );
  }
}
