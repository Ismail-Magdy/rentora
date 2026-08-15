import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class PriceDetailsCard extends StatelessWidget {
  final double dailyPrice;
  final int totalDays;
  final double serviceFee;
  final double securityDeposit;

  const PriceDetailsCard({
    super.key,
    required this.dailyPrice,
    required this.totalDays,
    required this.serviceFee,
    required this.securityDeposit,
  });

  @override
  Widget build(BuildContext context) {
    final rentalTotal = dailyPrice * totalDays;
    final grandTotal = rentalTotal + serviceFee + securityDeposit;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.receipt_long_outlined,
                color: AppColors.primaryColor,
                size: 18,
              ),
              horizontalSpace(8),
              const Text(
                "Price Details",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          verticalSpace(16),
          _priceRow(
            title: "Rental Cost (SAR ${dailyPrice.toInt()} × $totalDays days)",
            value: "$rentalTotal SAR",
          ),
          verticalSpace(12),
          _priceRow(title: "Service Fee", value: "$serviceFee SAR"),
          verticalSpace(12),
          _priceRow(title: "Security Deposit", value: "$securityDeposit SAR"),
          verticalSpace(14),
          Divider(height: 1, color: AppColors.dividerColor),
          verticalSpace(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.black,
                ),
              ),
              Text(
                "$grandTotal SAR",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: AppColors.grey, fontSize: 15),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
