import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';

class RentalRequestStatusCard extends StatelessWidget {
  final bool isAccepted;
  final String title;
  final String message;
  final BookingModel? booking;

  const RentalRequestStatusCard({
    super.key,
    required this.isAccepted,
    required this.title,
    required this.message,
    this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isAccepted ? AppColors.successDark : AppColors.error;
    final bgColor = isAccepted ? AppColors.successLight : AppColors.errorLight;
    final iconData = isAccepted ? Icons.check_rounded : Icons.close_rounded;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(iconData, size: 52.sp, color: iconColor),
        ),
        verticalSpace(20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        verticalSpace(10),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sp, color: AppColors.grey, height: 1.5),
        ),
        if (booking != null) ...[
          verticalSpace(20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Code:',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    Text(
                      booking!.orderCode,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                verticalSpace(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status:',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        booking!.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
