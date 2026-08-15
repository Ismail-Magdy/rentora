import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';

class RentalRequestStatusActions extends StatelessWidget {
  const RentalRequestStatusActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomButton(
          text: 'Back to My Listings',
          height: 52.h,
          fontSize: 16.sp,
          onPressed: () =>
              context.pushReplacementNamed(Routes.myRentalListingsScreen),
        ),
        verticalSpace(12),
        CustomButton(
          text: 'Go to Home',
          color: AppColors.white,
          textColor: AppColors.primaryColor,
          height: 50.h,
          fontSize: 15.sp,
          borderRadius: 14,
          onPressed: () => context.pushReplacementNamed(Routes.rootScreen),
        ),
      ],
    );
  }
}
