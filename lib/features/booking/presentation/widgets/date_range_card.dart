import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class DateRangeCard extends StatelessWidget {
  final String pickupDate;
  final String returnDate;
  final String totalDaysText;
  final String? pickupLabel;
  final String? returnLabel;

  const DateRangeCard({
    super.key,
    required this.pickupDate,
    required this.returnDate,
    required this.totalDaysText,
    this.pickupLabel = 'Pickup Date',
    this.returnLabel = 'Return Date',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pickupLabel!,
                style: const TextStyle(fontSize: 12, color: AppColors.grey),
              ),
              verticalSpace(4),
              Text(
                pickupDate,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Icon(
                Icons.arrow_forward,
                color: AppColors.primaryColor,
                size: 20,
              ),
              verticalSpace(4),
              Text(
                totalDaysText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                returnLabel!,
                style: const TextStyle(fontSize: 12, color: AppColors.grey),
              ),
              verticalSpace(4),
              Text(
                returnDate,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
