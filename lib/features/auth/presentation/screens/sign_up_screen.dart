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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
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
            'Account created successfully!',
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
        backgroundColor: AppColors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(height: 48.h),

                    AuthCard(
                      title: 'Create Account',
                      footer: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/loginScreen'),
                            child: Text(
                              'Log In',
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
                        CustomTextFormField(
                          controller: nameController,
                          hintText: 'Enter your full name',
                          prefixIcon: Icons.person_outline,
                        ),
                        SizedBox(height: 24.h),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: 'name@example.com',
                          prefixIcon: Icons.mail_outline,
                          fieldType: FieldType.email,
                        ),
                        SizedBox(height: 24.h),
                        CustomTextFormField(
                          controller: phoneController,
                          hintText: '+966 5X XXX XXXX',
                          prefixIcon: Icons.phone_android,
                          fieldType: FieldType.phoneNumber,
                        ),
                        SizedBox(height: 24.h),
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: '********',
                          prefixIcon: Icons.lock_outline,
                          fieldType: FieldType.password,
                        ),
                        SizedBox(height: 24.h),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 22.w,
                              height: 22.w,
                              child: Checkbox(
                                value: _agreedToTerms,
                                onChanged: (v) =>
                                    setState(() => _agreedToTerms = v ?? false),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade700,
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),

                        CustomButton(
                          text: 'Create Account',
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;

                            if (!_agreedToTerms) {
                              AppDialogs.showSnackBar(
                                context,
                                'Please agree to the Terms & Conditions first.',
                              );
                              return;
                            }

                            context.read<AuthCubit>().signUp(
                              name: nameController.text,
                              email: emailController.text,
                              phoneNumber: phoneController.text,
                              password: passwordController.text,
                              agreedToTerms: _agreedToTerms,
                            );
                          },
                        ),
                      ],
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
