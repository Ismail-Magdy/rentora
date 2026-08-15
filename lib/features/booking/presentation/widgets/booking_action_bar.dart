import 'package:flutter/material.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';

class BookingActionBar extends StatelessWidget {
  final String label;
  final String totalText;
  final String buttonText;
  final VoidCallback onPressed;
  final double? buttonWidth;

  const BookingActionBar({
    super.key,
    required this.label,
    required this.totalText,
    required this.buttonText,
    required this.onPressed,
    this.buttonWidth = 170,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: AppColors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  totalText,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            CustomButton(
              text: buttonText,
              width: buttonWidth,
              height: 52,
              borderRadius: 12,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
