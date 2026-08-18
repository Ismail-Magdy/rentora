import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svgs/logo.svg',
                  width: 100.w,
                  height: 110.h,
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8.w,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/R.svg',
                      width: 10.w,
                      height: 15.h,
                    ),
                    SvgPicture.asset(
                      'assets/svgs/E.svg',
                      width: 10.w,
                      height: 15.h,
                    ),
                    SvgPicture.asset(
                      'assets/svgs/N.svg',
                      width: 10.w,
                      height: 15.h,
                    ),
                    SvgPicture.asset(
                      'assets/svgs/T.svg',
                      width: 10.w,
                      height: 15.h,
                    ),
                    SvgPicture.asset(
                      'assets/svgs/O.svg',
                      width: 10.w,
                      height: 15.h,
                    ),
                    SvgPicture.asset(
                      'assets/svgs/R_Green.svg',
                      width: 10.w,
                      height: 15.h,
                    ),
                    SvgPicture.asset(
                      'assets/svgs/A.svg',
                      width: 10.w,
                      height: 15.h,
                    ),
                  ],
                ),
                SizedBox(height: 55.h),
                CustomButton(
                  width: 380.w,
                  height: 62.h,
                  text: 'Login',
                  borderRadius: 12.0,
                  borderColor: AppColors.primaryColor,
                  borderWidth: 1.0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/loginScreen');
                  },
                ),
                SizedBox(height: 30.h),
                CustomButton(
                  width: 380.w,
                  height: 62.h,
                  color: AppColors.white,
                  text: 'Register',
                  borderRadius: 12.0,
                  textColor: AppColors.primaryGreen,
                  borderColor: AppColors.primaryGreen,
                  borderWidth: 1.0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/signupScreen');
                  },
                ),

                SizedBox(height: 48.h),

                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.lightGrey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Or',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.lightGrey)),
                  ],
                ),

                SizedBox(height: 48.h),
                CustomButton(
                  width: 380.w,
                  height: 48.h,
                  color: AppColors.white,
                  text: 'Continue with Google',
                  textColor: AppColors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  borderRadius: 12.0,
                  borderColor: AppColors.lightGrey,
                  icon: SvgPicture.asset(
                    'assets/svgs/Google.svg',
                    width: 24.w,
                    height: 24.h,
                  ),
                  onPressed: () {
                    // Handle Google login
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
