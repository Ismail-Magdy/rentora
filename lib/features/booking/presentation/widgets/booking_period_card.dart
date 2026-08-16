import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: AppColors.primaryColor,
                size: 18.r,
              ),
              horizontalSpace(8),
              Text(
                "Selected Dates",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 17.sp,
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
                  Text(
                    "Pickup",
                    style: TextStyle(color: AppColors.grey, fontSize: 12.sp),
                  ),
                  verticalSpace(4),
                  Text(
                    startDate,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    "10:00 PM",
                    style: TextStyle(color: AppColors.grey, fontSize: 12.sp),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Text(
                      totalDays,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 16.r,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Return",
                    style: TextStyle(color: AppColors.grey, fontSize: 12.sp),
                  ),
                  verticalSpace(4),
                  Text(
                    endDate,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    "10:00 AM",
                    style: TextStyle(color: AppColors.grey, fontSize: 12.sp),
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
