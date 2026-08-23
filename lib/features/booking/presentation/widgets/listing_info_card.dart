import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class ListingInfoCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double dailyPrice;

  const ListingInfoCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.dailyPrice,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppColors.darkShadow
                : AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Image.network(
              imageUrl,
              width: 82.w,
              height: 82.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 82.w,
                height: 82.h,
                color: isDark ? AppColors.darkContainer : AppColors.lightGrey,
                child: Icon(
                  Icons.camera_alt,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                ),
              ),
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Available',
                    style: TextStyle(
                      color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                verticalSpace(8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(8),
                Row(
                  children: [
                    Icon(Icons.star, color: AppColors.amber, size: 16.r),
                    horizontalSpace(4),
                    Text(
                      '(reviews 24)',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    horizontalSpace(8),
                    Text(
                      '4.9',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                verticalSpace(8),
                Text(
                  '${dailyPrice.toStringAsFixed(0)} SAR / day',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
