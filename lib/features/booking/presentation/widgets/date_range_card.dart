import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pickupLabel!,
                style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
              ),
              verticalSpace(4),
              Text(
                pickupDate,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.arrow_forward,
                color: AppColors.primaryColor,
                size: 20.r,
              ),
              verticalSpace(4),
              Text(
                totalDaysText,
                style: TextStyle(
                  fontSize: 12.sp,
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
                style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
              ),
              verticalSpace(4),
              Text(
                returnDate,
                style: TextStyle(
                  fontSize: 14.sp,
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
