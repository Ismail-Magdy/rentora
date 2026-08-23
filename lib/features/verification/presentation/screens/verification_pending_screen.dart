import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar_without_leading.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/verification/presentation/widgets/pending_status_card.dart';
import 'package:rentora/features/verification/presentation/widgets/verification_support_footer.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class VerificationPendingScreen extends StatelessWidget {
  const VerificationPendingScreen({super.key});

  void _showSupportDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showFeedbackDialog(
      context,
      icon: Icons.support_agent_rounded,
      color: AppColors.primaryColor,
      title: l10n.rentoraSupport,
      message: l10n.rentoraSupportMessage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBarWithNoLeading(text: l10n.verificationAppBarTitle),
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
              const Spacer(flex: 3),
              VerificationSupportFooter(
                onContactSupport: () => _showSupportDialog(context),
              ),
              verticalSpace(10),
            ],
          ),
        ),
      ),
    );
  }
}
