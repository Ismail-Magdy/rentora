import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/on_boarding/data/on_boarding_screens_data.dart';

Widget buildOnBoardingScreen(BuildContext context, OnboardingItem data) {
  final isDark = context.isDarkMode;
  return Padding(
    padding: .symmetric(horizontal: 25.w),
    child: Column(
      children: [
        //
        Text(
          data.title,
          textAlign: .center,
          style: TextStyle(
            color: isDark ? AppColors.darkTextPrimary : AppColors.primaryColor,
            fontSize: 35.sp,
            fontWeight: .w700,
          ),
        ),
        //
        verticalSpace(22),
        //
        Text(
          data.description,
          textAlign: .center,
          style: TextStyle(
            color: isDark ? AppColors.darkTextSecondary : AppColors.darkGrey,
            fontSize: 16.sp,
            fontWeight: .w400,
          ),
        ),
        //
        verticalSpace(60),
        //
        Expanded(
          child: Center(
            child: Image.asset(
              data.image,
              width: 327.w,
              height: 263.h,
              fit: .contain,
            ),
          ),
        ),
        //
      ],
    ),
  );
}
