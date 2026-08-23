import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:lottie/lottie.dart";
import "package:rentora/core/themes/app_colors.dart";
import "package:rentora/l10n/generated/app_localizations.dart";
import "../helpers/spacing.dart";

class OfflineModeWidget extends StatelessWidget {
  const OfflineModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: .symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                // Lottie Animation
                Lottie.asset(
                  "assets/lottie/offline.json",
                  height: 250.h,
                  fit: .contain,
                ),
                //
                verticalSpace(30),
                //
                Text(
                  l10n.noInternetConnection,
                  textAlign: .center,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: .bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                //
                verticalSpace(12),
                //
                Text(
                  l10n.checkConnection,
                  textAlign: .center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: .normal,
                    color: AppColors.secondaryColor,
                  ),
                ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
