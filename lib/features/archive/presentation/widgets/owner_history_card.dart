import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';

class OwnerHistoryCard extends StatelessWidget {
  final BookingModel booking;
  final String? itemImageUrl;
  final String? itemTitle;

  const OwnerHistoryCard({
    super.key,
    required this.booking,
    this.itemImageUrl,
    this.itemTitle,
  });

  Color _getStatusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'returned':
        return AppColors.successLight;
      case 'approved':
      case 'active':
        return AppColors.infoLight;
      case 'pending':
        return AppColors.amberLight;
      case 'rejected':
      case 'cancelled':
        return AppColors.errorLight;
      default:
        return AppColors.lightGrey.withValues(alpha: 0.3);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'returned':
        return AppColors.successDark;
      case 'approved':
      case 'active':
        return AppColors.primaryColor;
      case 'pending':
        return AppColors.amberDark;
      case 'rejected':
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.darkGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBg = _getStatusBgColor(booking.status);
    final statusText = _getStatusTextColor(booking.status);
    final displayTitle = itemTitle ?? 'Listing #${booking.listingId}';
    final displayImage =
        itemImageUrl ??
        'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=600';

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  displayImage,
                  width: 74.w,
                  height: 74.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 74.w,
                    height: 74.h,
                    color: AppColors.lightGrey,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.grey,
                    ),
                  ),
                ),
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
                            displayTitle,
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
                            color: statusBg,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            booking.status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: statusText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(4),
                    Text(
                      'Renter ID: ${booking.renterId.isNotEmpty ? booking.renterId.substring(0, booking.renterId.length > 8 ? 8 : booking.renterId.length) : 'Guest'}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpace(4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 13.sp,
                          color: AppColors.grey,
                        ),
                        horizontalSpace(4),
                        Text(
                          '${booking.startDate} - ${booking.endDate}',
                          style: TextStyle(
                            fontSize: 11.5.sp,
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
          verticalSpace(12),
          const Divider(height: 1, color: AppColors.dividerColor),
          verticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Earnings',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  Text(
                    '${booking.totalAmount} SAR',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              CustomButton(
                text: 'Review Request',
                width: 120.w,
                height: 38.h,
                fontSize: 12.5.sp,
                borderRadius: 10,
                onPressed: () {
                  context.pushNamed(
                    Routes.incomingRentalRequestScreen,
                    arguments: booking,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
