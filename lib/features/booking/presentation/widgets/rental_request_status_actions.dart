import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class RentalRequestStatusActions extends StatelessWidget {
  const RentalRequestStatusActions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomButton(
          text: l10n.myListings,
          height: 52.h,
          fontSize: 16.sp,
          onPressed: () =>
              context.pushReplacementNamed(Routes.myRentalListingsScreen),
        ),
        verticalSpace(12),
        CustomButton(
          text: l10n.backToHome,
          color: isDark ? AppColors.darkSurface : AppColors.white,
          textColor: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
          borderColor: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
          height: 50.h,
          fontSize: 15.sp,
          borderRadius: 14,
          onPressed: () => context.pushReplacementNamed(Routes.rootScreen),
        ),
      ],
    );
  }
}
