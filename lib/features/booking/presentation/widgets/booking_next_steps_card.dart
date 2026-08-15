import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class BookingNextStepsCard extends StatelessWidget {
  final List<String> steps;

  const BookingNextStepsCard({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: AppColors.primaryColor,
                size: 20,
              ),
              horizontalSpace(8),
              const Text(
                "What's next",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          verticalSpace(12),
          for (final step in steps) ...[
            _buildNextStep(step),
            verticalSpace(12),
          ],
        ],
      ),
    );
  }

  Widget _buildNextStep(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: AppColors.white, size: 12),
        ),
        horizontalSpace(12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.primaryColor,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
