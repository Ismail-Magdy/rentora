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
import 'package:rentora/l10n/generated/app_localizations.dart';
import 'package:rentora/features/auth/manager/auth_cubit.dart';
import 'package:rentora/features/auth/manager/auth_state.dart';
import 'package:rentora/features/auth/presentation/widgets/auth_divider.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        if (state is AuthError) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline_rounded,
            color: AppColors.error,
            title: l10n.loginFailed,
            message: state.failure.message,
          );
        } else if (state is AuthSuccess) {
          showFeedbackDialog(
            context,
            icon: Icons.check_circle_outline_rounded,
            color: AppColors.primaryGreen,
            title: l10n.welcomeBack,
            message: l10n.loginSuccess,
            onFinish: () => context.pushNamedAndRemoveUntil(
              Routes.locationScreen,
              predicate: (route) => false,
            ),
          );
        }
      },
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
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
                          //
                          SvgPicture.asset(
                            height: 120.h,
                            width: 120.w,
                            "assets/svgs/logo/all_logo.svg",
                          ),
                          //
                          verticalSpace(32),
                          //
                          Text(
                            l10n.welcomeBack,
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
                            l10n.loginContinue,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.grey,
                            ),
                          ),
                          //
                          verticalSpace(40),
                          //
                          CustomTextFormField(
                            controller: emailController,
                            hintText: l10n.enterEmail,
                            prefixIcon: Icons.mail_outline,
                            fieldType: .email,
                          ),
                          //
                          verticalSpace(24),
                          //
                          CustomTextFormField(
                            controller: passwordController,
                            hintText: '********',
                            prefixIcon: Icons.lock_outline,
                            fieldType: .loginPassword,
                          ),
                          //
                          verticalSpace(15),
                          //
                          GestureDetector(
                            onTap: () =>
                                context.pushNamed(Routes.forgotPasswordScreen),
                            child: Align(
                              alignment: .centerRight,
                              child: Text(
                                l10n.forgetPassword,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryColor,
                                  fontWeight: .w600,
                                ),
                              ),
                            ),
                          ),
                          //
                          verticalSpace(20),
                          //
                          state is AuthLoading
                              ? const Center(
                                  child: CupertinoActivityIndicator(
                                    color: AppColors.primaryGreen,
                                  ),
                                )
                              : CustomButton(
                                  height: 52.h,
                                  text: l10n.logIn,
                                  fontWeight: .w600,
                                  onPressed: () {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }
                                    context.read<AuthCubit>().login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  },
                                ),
                          //
                          verticalSpace(32),
                          //
                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              Text(
                                '${l10n.noAccount} ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    context.pushNamed(Routes.signupScreen),
                                child: Text(
                                  l10n.signUp,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.primaryGreen,
                                    fontWeight: .w600,
                                  ),
                                ),
                              ),
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
                                  text: l10n.continueGoogle,
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
