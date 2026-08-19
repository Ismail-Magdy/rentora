import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/error_screen.dart';
import 'package:rentora/features/auth/manager/auth_cubit.dart';
import 'package:rentora/features/auth/manager/auth_state.dart';

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
        } else if (state is AuthError) {
          ErrorScreen();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: .all(24.w),
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  children: [
                    //
                    SvgPicture.asset(
                      "assets/svgs/logo/all_logo.svg",
                      width: 200.w,
                      height: 200.h,
                    ),
                    //
                    verticalSpace(60),
                    //
                    CustomButton(
                      height: 52.h,
                      text: "Login",
                      onPressed: () => context.pushNamed(Routes.loginScreen),
                    ),
                    //
                    SizedBox(height: 30.h),
                    //
                    CustomButton(
                      width: 380.w,
                      height: 62.h,
                      color: AppColors.white,
                      text: 'Register',
                      borderRadius: 12.0,
                      textColor: AppColors.primaryGreen,
                      onPressed: () {
                        Navigator.pushNamed(context, '/signupScreen');
                      },
                    ),

                    SizedBox(height: 48.h),

                    // فاصل الـ Or
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

                    state is AuthLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryGreen,
                            ),
                          )
                        : CustomButton(
                            width: 380.w,
                            height: 48.h,
                            color: AppColors.white,
                            text: 'Continue with Google',
                            textColor: AppColors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            borderRadius: 12.0,
                            onPressed: () {
                              context.read<AuthCubit>().signInWithGoogle();
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
// 168