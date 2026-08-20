import 'package:flutter/material.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/core/network/firebase/users_firestore_service.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';

class VerificationGuard {
  VerificationGuard._();

  /// Checks the current user's verification status and branches:
  /// - verified → calls [onVerified]
  /// - pending → shows a feedback dialog (under review)
  /// - null / 'unverified' / other → navigates to verification intro
  static Future<void> check(
    BuildContext context, {
    required VoidCallback onVerified,
  }) async {
    final userId = getIt<FirebaseAuthService>().getCurrentUserId();
    if (userId == null || userId.isEmpty) return;

    final doc = await getIt<UsersFirestoreService>().getUserProfile(
      userId: userId,
    );
    final data = doc.data();
    final status = data?['verificationStatus'] as String?;

    if (!context.mounted) return;

    if (status == 'verified') {
      onVerified();
    } else if (status == 'pending') {
      showFeedbackDialog(
        context,
        icon: Icons.hourglass_top_rounded,
        color: AppColors.amberDark,
        title: 'Verification Under Review',
        message:
            'Your account verification is currently under review. This usually takes less than 24 hours.',
      );
    } else {
      context.pushNamed(Routes.verificationIntroScreen);
    }
  }
}
