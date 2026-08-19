import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class PickupLocationCard extends StatelessWidget {
  final String title;
  final String address;
  final String distance;

  const PickupLocationCard({
    super.key,
    required this.title,
    required this.address,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: AppColors.primaryColor,
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                horizontalSpace(4),
                Text(
                  address,
                  style: TextStyle(color: AppColors.grey, fontSize: 12.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          horizontalSpace(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              distance,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
