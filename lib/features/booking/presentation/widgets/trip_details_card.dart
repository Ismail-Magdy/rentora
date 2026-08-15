import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class TripDetailsCard extends StatelessWidget {
  final String checkIn;
  final String checkOut;
  final String duration;
  final String dailyPrice;
  final String securityDeposit;
  final String total;

  const TripDetailsCard({
    super.key,
    required this.checkIn,
    required this.checkOut,
    required this.duration,
    required this.dailyPrice,
    required this.securityDeposit,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trip Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),
          verticalSpace(14),
          _detailRow('Check-in', checkIn),
          verticalSpace(12),
          _detailRow('Check-out', checkOut),
          verticalSpace(12),
          _detailRow('Duration', duration),
          verticalSpace(12),
          _detailRow('Daily Price', dailyPrice),
          verticalSpace(12),
          _detailRow('Security Deposit', securityDeposit),
          verticalSpace(12),
          _detailRow('Total', total),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
