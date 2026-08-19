import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentora/core/helpers/app_dialog.dart';

import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_auth_card.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_text_field.dart';
import 'package:rentora/features/auth/manager/auth_cubit.dart';
import 'package:rentora/features/auth/manager/auth_state.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          AppDialogs.showLoading(context);
        } else if (state is AuthError) {
          AppDialogs.hideLoading(context);
          AppDialogs.showSnackBar(context, state.failure.message);
        } else if (state is PasswordResetSent) {
          AppDialogs.hideLoading(context);
          AppDialogs.showSnackBar(
            context,
            'Reset link sent to ${state.email}',
            isError: false,
          );
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F3F4),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Form(
                key: formKey,
                child: AuthCard(
                  title: 'Forgot Password',
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/logo.svg',
                      width: 90.w,
                      height: 90.h,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Enter your email and we will send you a link to reset your password.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 28.h),

                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'Enter your email address',
                      prefixIcon: Icons.mail_outline,
                      fieldType: FieldType.email,
                    ),
                    SizedBox(height: 24.h),

                    CustomButton(
                      width: double.infinity,
                      height: 50.h,
                      text: 'Send Reset Link',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;

                        context.read<AuthCubit>().sendPasswordReset(
                          email: emailController.text,
                        );
                      },
                    ),
                    SizedBox(height: 20.h),

                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Back to Login',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
