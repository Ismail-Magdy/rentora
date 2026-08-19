import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class MyRequestedRentalCard extends StatelessWidget {
  final String title;
  final String dates;
  final String status;
  final String amount;
  final String imageUrl;
  final VoidCallback? onTap;

  const MyRequestedRentalCard({
    super.key,
    required this.title,
    required this.dates,
    required this.status,
    required this.amount,
    this.imageUrl = '',
    this.onTap,
  });

  Color _getStatusColor(String statusText) {
    switch (statusText.toLowerCase()) {
      case 'accepted':
      case 'approved':
        return AppColors.successDark;
      case 'pending':
        return AppColors.warning;
      case 'rejected':
      case 'declined':
      case 'cancelled':
      default:
        return AppColors.error;
    }
  }

  Color _getStatusBgColor(String statusText) {
    switch (statusText.toLowerCase()) {
      case 'accepted':
      case 'approved':
        return AppColors.successLight;
      case 'pending':
        return AppColors.warning.withValues(alpha: 0.12);
      case 'rejected':
      case 'declined':
      case 'cancelled':
      default:
        return AppColors.errorLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(status);
    final statusBgColor = _getStatusBgColor(status);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(12.r),
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
            horizontalSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusBgColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 13,
                        color: AppColors.grey,
                      ),
                      horizontalSpace(4),
                      Text(
                        dates,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(8),
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 80.w,
      height: 80.h,
      color: AppColors.lightGrey,
      child: const Icon(Icons.shopping_bag_outlined, color: AppColors.grey),
    );
  }
}
