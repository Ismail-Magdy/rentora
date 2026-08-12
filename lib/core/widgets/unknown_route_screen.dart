import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: .symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              //
              Lottie.asset(
                "assets/lottie/no_data.json",
                width: 250.w,
                height: 250.h,
              ),
              //
              Text(
                "Looks like you're off the map",
                textAlign: .center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: .bold,
                  color: AppColors.primaryColor,
                ),
              ),
              //
              verticalSpace(12),
              //
              Text(
                "The page you are looking for does not exist or has been moved",
                textAlign: .center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.secondaryColor,
                ),
              ),
              //
              verticalSpace(40),
              //
              CustomButton(text: "Go Back", onPressed: () => context.pop()),
            ],
          ),
        ),
      ),
    );
  }
}
