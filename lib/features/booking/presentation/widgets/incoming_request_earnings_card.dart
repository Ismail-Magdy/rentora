import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class IncomingRequestEarningsCard extends StatelessWidget {
  final double totalAmount;
  final double platformFeePercentage;
  final String currency;

  const IncomingRequestEarningsCard({
    super.key,
    required this.totalAmount,
    this.platformFeePercentage = 0.10,
    this.currency = 'SAR',
  });

  @override
  Widget build(BuildContext context) {
    final platformFee = totalAmount * platformFeePercentage;
    final netEarnings = totalAmount - platformFee;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Earnings Summary',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
          verticalSpace(12),
          _buildRow(
            'Total Rental Price',
            '${totalAmount.toStringAsFixed(0)} $currency',
            false,
          ),
          verticalSpace(8),
          _buildRow(
            'Platform Fee (${(platformFeePercentage * 100).toInt()}%)',
            '-${platformFee.toStringAsFixed(0)} $currency',
            false,
            isDeduction: true,
          ),
          verticalSpace(12),
          const Divider(color: AppColors.lightGrey, thickness: 1),
          verticalSpace(8),
          _buildRow(
            'Estimated Net Earnings',
            '${netEarnings.toStringAsFixed(0)} $currency',
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value,
    bool isBold, {
    bool isDeduction = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 15.sp : 13.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isBold ? AppColors.black : AppColors.darkGrey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16.sp : 13.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold
                ? AppColors.primaryColor
                : (isDeduction ? AppColors.error : AppColors.black),
          ),
        ),
      ],
    );
  }
}
