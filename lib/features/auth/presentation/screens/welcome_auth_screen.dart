import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/auth/manager/auth_cubit.dart';
import 'package:rentora/features/auth/manager/auth_state.dart';
import 'package:rentora/features/auth/presentation/widgets/auth_divider.dart';

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          //
          showFeedbackDialog(
            context,
            icon: Icons.check_circle_outline,
            color: AppColors.primaryGreen,
            title: "Success",
            message: "You have successfully logged in",
            onFinish: () => context.pushReplacementNamed(Routes.locationScreen),
          );
        } else if (state is AuthError) {
          //
          showFeedbackDialog(
            context,
            icon: Icons.error_outline_rounded,
            color: AppColors.error,
            title: "Login Failed",
            message: state.failure.message,
          );
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
                    verticalSpace(25),
                    //
                    CustomButton(
                      height: 52.h,
                      color: AppColors.white,
                      text: "Register",
                      borderColor: AppColors.secondaryColor,
                      textColor: AppColors.secondaryColor,
                      onPressed: () => context.pushNamed(Routes.signupScreen),
                    ),
                    //
                    verticalSpace(48),
                    // Or
                    const AuthDivider(),
                    //
                    verticalSpace(48),
                    //
                    state is AuthLoading
                        ? const Center(
                            child: CupertinoActivityIndicator(
                              color: AppColors.primaryGreen,
                            ),
                          )
                        : CustomButton(
                            height: 52.h,
                            color: AppColors.white,
                            text: "Continue with Google",
                            textColor: AppColors.black,
                            borderColor: AppColors.lightGrey,
                            fontSize: 16.sp,
                            fontWeight: .w400,
                            prefixIcon: SvgPicture.asset(
                              "assets/svgs/auth/google.svg",
                              width: 24.w,
                              height: 24.h,
                            ),
                            onPressed: () =>
                                context.read<AuthCubit>().signInWithGoogle(),
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
