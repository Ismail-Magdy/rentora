import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/core/widgets/custom_text_field.dart';
import 'package:rentora/features/auth/manager/auth_cubit.dart';
import 'package:rentora/features/auth/manager/auth_state.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline_rounded,
            color: AppColors.error,
            title: l10n.resetFailed,
            message: state.failure.message,
          );
        } else if (state is PasswordResetSent) {
          showFeedbackDialog(
            context,
            icon: Icons.mark_email_read_outlined,
            color: AppColors.primaryColor,
            title: l10n.emailSent,
            message: l10n.resetLinkSent,
            onFinish: () => context.pop(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(text: l10n.forgotPassword),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: .symmetric(horizontal: 24.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(40),
                      Text(
                        l10n.enterEmailResetDescription,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey,
                          height: 1.5,
                        ),
                        textAlign: .center,
                      ),

                      verticalSpace(48),

                      Text(
                        l10n.enterEmail,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: .w600,
                          color: AppColors.black,
                        ),
                      ),
                      verticalSpace(8),

                      CustomTextFormField(
                        controller: emailController,
                        hintText: l10n.enterEmail,
                        prefixIcon: Icons.mail_outline,
                        fieldType: .email,
                      ),

                      verticalSpace(32),

                      state is AuthLoading
                          ? const Center(
                              child: CupertinoActivityIndicator(
                                color: AppColors.primaryGreen,
                              ),
                            )
                          : CustomButton(
                              height: 52.h,
                              text: l10n.sendResetLink,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              onPressed: () {
                                if (!formKey.currentState!.validate()) return;
                                context.read<AuthCubit>().sendPasswordReset(
                                  email: emailController.text,
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
