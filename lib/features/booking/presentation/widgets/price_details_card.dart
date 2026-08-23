import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final rentalTotal = dailyPrice * totalDays;
    final grandTotal = rentalTotal + serviceFee + securityDeposit;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                color: AppColors.primaryColor,
                size: 18.r,
              ),
              horizontalSpace(8),
              Text(
                l10n.priceDetails,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          verticalSpace(16),
          _priceRow(
            title:
                '${l10n.rentalCost} (${l10n.sar} ${dailyPrice.toInt()} × $totalDays ${l10n.days})',
            value: "$rentalTotal SAR",
          ),
          verticalSpace(12),
          _priceRow(title: l10n.serviceFee, value: "$serviceFee SAR"),
          verticalSpace(12),
          _priceRow(
            title: l10n.securityDepositLabel,
            value: "$securityDeposit SAR",
          ),
          verticalSpace(14),
          Divider(height: 1.h, color: AppColors.dividerColor),
          verticalSpace(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.total,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: AppColors.black,
                ),
              ),
              Text(
                "$grandTotal SAR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
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
          style: TextStyle(color: AppColors.grey, fontSize: 15.sp),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
}
