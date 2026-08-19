import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/verification/presentation/widgets/pending_status_card.dart';
import 'package:rentora/features/verification/presentation/widgets/verification_support_footer.dart';

class VerificationPendingScreen extends StatelessWidget {
  const VerificationPendingScreen({super.key});

  void _showSupportDialog(BuildContext context) {
    showFeedbackDialog(
      context,
      icon: Icons.support_agent_rounded,
      color: AppColors.primaryColor,
      title: "Rentora Support",
      message:
          "Our support team is available 24/7 to assist you with your account verification.",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(text: "Account Verification"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              const Spacer(flex: 2),
              PendingStatusCard(
                onBackToHome: () => context.pushNamedAndRemoveUntil(
                  Routes.rootScreen,
                  predicate: (route) => false,
                ),
              ),
              verticalSpace(24),
              VerificationSupportFooter(
                onContactSupport: () => _showSupportDialog(context),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
