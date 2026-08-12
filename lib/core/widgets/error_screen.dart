import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:rentora/core/themes/app_colors.dart";
import "../helpers/spacing.dart";

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              "Something went wrong",
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
              "Please try again later",
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
