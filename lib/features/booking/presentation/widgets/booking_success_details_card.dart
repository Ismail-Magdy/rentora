import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class BookingSuccessDetailsCard extends StatelessWidget {
  final String listingTitle;
  final String listingImageUrl;
  final String orderCode;
  final String dateRange;
  final String totalAmount;

  const BookingSuccessDetailsCard({
    super.key,
    required this.listingTitle,
    required this.listingImageUrl,
    required this.orderCode,
    required this.dateRange,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  listingImageUrl,
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60.w,
                    height: 60.h,
                    color: AppColors.lightGrey,
                    child: const Icon(Icons.camera_alt, color: AppColors.grey),
                  ),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listingTitle,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(4),
                    Text(
                      'Booking ID: $orderCode',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.grey,
                      ),
                    ),
                    verticalSpace(4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14.r,
                          color: AppColors.grey,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          dateRange,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(12),
          Container(height: 1.h, color: AppColors.lightGrey),
          verticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
              ),
              Text(
                '$totalAmount SAR',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
