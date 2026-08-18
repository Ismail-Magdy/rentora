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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
        } else if (state is AuthSuccess) {
          AppDialogs.hideLoading(context);
          AppDialogs.showSnackBar(
            context,
            'Welcome back, ${state.user.name}!',
            isError: false,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/homeScreen',
            (route) => false,
          );
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
                  footer: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/signupScreen'),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/logo.svg',
                      width: 90.w,
                      height: 90.h,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Welcome back! Log in to continue.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'Enter your email address',
                      prefixIcon: Icons.mail_outline,
                      fieldType: FieldType.email,
                    ),
                    SizedBox(height: 24.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF3B4A5A),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/forgotPasswordScreen',
                          ),
                          child: Text(
                            'Forget password?',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),

                    CustomTextFormField(
                      controller: passwordController,
                      hintText: '********',
                      prefixIcon: Icons.lock_outline,
                      fieldType: FieldType.password,
                    ),
                    SizedBox(height: 24.h),

                    CustomButton(
                      width: double.infinity,
                      height: 50.h,
                      text: 'Log In',
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;

                        context.read<AuthCubit>().login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                    ),
                    SizedBox(height: 20.h),

                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'Or',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    CustomButton(
                      width: double.infinity,
                      height: 50.h,
                      text: 'Continue with Google',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                      textColor: AppColors.black,

                      onPressed: () {
                        // Google Sign-In هنا بعدين
                      },
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
