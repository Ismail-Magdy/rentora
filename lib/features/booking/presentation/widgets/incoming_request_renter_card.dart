import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class IncomingRequestRenterCard extends StatelessWidget {
  final String renterName;
  final String avatarUrl;
  final String rating;
  final String reviewsCountText;
  final bool isVerified;

  const IncomingRequestRenterCard({
    super.key,
    required this.renterName,
    required this.avatarUrl,
    required this.rating,
    required this.reviewsCountText,
    this.isVerified = true,
  });

  @override
  Widget build(BuildContext context) {
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
            'Renter Information',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
          verticalSpace(12),
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: AppColors.lightGrey,
                backgroundImage: avatarUrl.isNotEmpty
                    ? NetworkImage(avatarUrl)
                    : null,
                child: avatarUrl.isEmpty
                    ? const Icon(Icons.person, color: AppColors.grey)
                    : null,
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          renterName,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        horizontalSpace(6),
                        if (isVerified)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.successLight,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified,
                                  size: 12.r,
                                  color: AppColors.successDark,
                                ),
                                horizontalSpace(3),
                                Text(
                                  'Verified',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.successDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    verticalSpace(4),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 16.r,
                          color: AppColors.warning,
                        ),
                        horizontalSpace(4),
                        Text(
                          '$rating ($reviewsCountText)',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
