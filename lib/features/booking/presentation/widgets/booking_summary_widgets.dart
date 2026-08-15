import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class BookingPeriodCard extends StatelessWidget {
  final String startDate;
  final String endDate;
  final String totalDays;

  const BookingPeriodCard({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: AppColors.primaryColor,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                "Selected Dates",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          verticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pickup",
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                  verticalSpace(4),
                  Text(
                    startDate,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "10:00 PM",
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      totalDays,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Return",
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                  verticalSpace(4),
                  Text(
                    endDate,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "10:00 AM",
                    style: TextStyle(color: AppColors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
              const SizedBox(width: 8),
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
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFEAEAEA)),
          const SizedBox(height: 14),
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
