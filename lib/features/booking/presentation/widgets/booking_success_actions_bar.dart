import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';

class BookingSuccessActionsBar extends StatelessWidget {
  final VoidCallback onViewDetails;
  final VoidCallback onBackToHome;

  const BookingSuccessActionsBar({
    super.key,
    required this.onViewDetails,
    required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: 'View Booking Details',
              height: 52,
              borderRadius: 12,
              onPressed: onViewDetails,
            ),
            verticalSpace(12),
            CustomButton(
              text: 'Back to Home',
              color: AppColors.white,
              textColor: AppColors.primaryColor,
              height: 52,
              borderRadius: 12,
              onPressed: onBackToHome,
            ),
          ],
        ),
      ),
    );
  }
}
