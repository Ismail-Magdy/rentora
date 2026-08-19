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
import 'package:rentora/core/widgets/custom_text_field.dart';
import 'package:rentora/features/auth/manager/auth_cubit.dart';
import 'package:rentora/features/auth/manager/auth_state.dart';
import 'package:rentora/features/auth/presentation/widgets/auth_divider.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          //
          showFeedbackDialog(
            context,
            icon: Icons.error_outline_rounded,
            color: AppColors.error,
            title: "Registration Failed",
            message: state.failure.message,
          );
          //
        } else if (state is AuthSuccess) {
          //
          showFeedbackDialog(
            context,
            icon: Icons.check_circle_outline_rounded,
            color: AppColors.primaryGreen,
            title: "Success",
            message: "Your account has been created successfully",
            onFinish: () => context.pushNamedAndRemoveUntil(
              Routes.rootScreen,
              predicate: (route) => false,
            ),
          );
          //
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: .center,
                  children: [
                    //
                    Column(
                      children: [
                        Padding(
                          padding: .symmetric(horizontal: 15.w),
                          child: Align(
                            alignment: .centerLeft,
                            child: GestureDetector(
                              onTap: () => context.pop(),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //
                    Padding(
                      padding: .symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          verticalSpace(20),
                          //
                          SvgPicture.asset(
                            height: 120.h,
                            width: 120.w,
                            "assets/svgs/logo/all_logo.svg",
                          ),
                          //
                          verticalSpace(30),
                          //
                          Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: .bold,
                              color: AppColors.black,
                            ),
                          ),
                          //
                          verticalSpace(8),
                          //
                          Text(
                            "Join our community today",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.grey,
                            ),
                          ),
                          //
                          verticalSpace(40),
                          //
                          CustomTextFormField(
                            controller: nameController,
                            hintText: "Enter your full name",
                            prefixIcon: Icons.person_outline,
                          ),
                          //
                          verticalSpace(24),
                          //
                          CustomTextFormField(
                            controller: emailController,
                            hintText: "ahmedali@gmail.com",
                            prefixIcon: Icons.mail_outline,
                            fieldType: .email,
                          ),
                          //
                          verticalSpace(24),
                          //
                          CustomTextFormField(
                            controller: phoneController,
                            hintText: "01206607906",
                            prefixIcon: Icons.phone_android,
                            fieldType: .phoneNumber,
                          ),
                          //
                          verticalSpace(24),
                          //
                          CustomTextFormField(
                            controller: passwordController,
                            hintText: "********",
                            prefixIcon: Icons.lock_outline,
                            fieldType: .password,
                          ),
                          //
                          verticalSpace(24),
                          //
                          Row(
                            crossAxisAlignment: .start,
                            children: [
                              //
                              SizedBox(
                                width: 22.w,
                                height: 22.w,
                                child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: .circular(4.r),
                                  ),
                                  value: _agreedToTerms,
                                  activeColor: AppColors.secondaryColor,
                                  onChanged: (value) => setState(
                                    () => _agreedToTerms = value ?? false,
                                  ),
                                ),
                              ),
                              //
                              horizontalSpace(10),
                              //
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.black,
                                      fontWeight: .bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Terms & Conditions",
                                        style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                      const TextSpan(text: " and "),
                                      TextSpan(
                                        text: "Privacy Policy",
                                        style: TextStyle(
                                          color: AppColors.secondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //
                            ],
                          ),
                          //
                          verticalSpace(32),
                          //
                          state is AuthLoading
                              ? const Center(
                                  child: CupertinoActivityIndicator(
                                    color: AppColors.primaryGreen,
                                  ),
                                )
                              : CustomButton(
                                  text: "Create Account",
                                  onPressed: () {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }

                                    if (!_agreedToTerms) {
                                      showFeedbackDialog(
                                        context,
                                        icon: Icons.warning_amber_rounded,
                                        color: Colors.orange,
                                        title: "Action Required",
                                        message:
                                            "Please agree to the Terms & Conditions first",
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
                          //
                          verticalSpace(24),
                          //
                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              //
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.grey,
                                ),
                              ),
                              //
                              GestureDetector(
                                onTap: () =>
                                    context.pushNamed(Routes.loginScreen),
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.secondaryColor,
                                    fontWeight: .w600,
                                  ),
                                ),
                              ),
                              //
                            ],
                          ),
                          //
                          verticalSpace(32),
                          //
                          AuthDivider(),
                          //
                          verticalSpace(32),
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
                                  onPressed: () => context
                                      .read<AuthCubit>()
                                      .signInWithGoogle(),
                                ),

                          verticalSpace(24),
                        ],
                      ),
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
