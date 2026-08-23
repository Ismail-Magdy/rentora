import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class BookingSuccessActionsBar extends StatelessWidget {
  final VoidCallback onViewDetails;
  final VoidCallback onBackToHome;

  const BookingSuccessActionsBar({
    super.key,
    required this.onViewDetails,
    required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: l10n.viewDetails,
              height: 52.h,
              borderRadius: 12,
              onPressed: onViewDetails,
            ),
            verticalSpace(12),
            CustomButton(
              text: l10n.backToHome,
              color: isDark ? AppColors.darkSurface : AppColors.white,
              textColor: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
              borderColor: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
              height: 52.h,
              borderRadius: 12,
              onPressed: onBackToHome,
            ),
          ],
        ),
      ),
    );
  }
}
