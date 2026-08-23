import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';

class RenterHistoryCard extends StatelessWidget {
  final BookingModel booking;
  final String? itemImageUrl;
  final String? itemTitle;

  const RenterHistoryCard({
    super.key,
    required this.booking,
    this.itemImageUrl,
    this.itemTitle,
  });

  Color _getStatusBgColor(String status, bool isDark) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'returned':
        return isDark
            ? AppColors.successDark.withValues(alpha: 0.2)
            : AppColors.successLight;
      case 'approved':
      case 'active':
        return isDark
            ? AppColors.secondaryColor.withValues(alpha: 0.2)
            : AppColors.infoLight;
      case 'pending':
        return isDark
            ? AppColors.amberDark.withValues(alpha: 0.2)
            : AppColors.amberLight;
      case 'rejected':
      case 'cancelled':
        return isDark
            ? AppColors.error.withValues(alpha: 0.2)
            : AppColors.errorLight;
      default:
        return isDark
            ? AppColors.darkContainer
            : AppColors.lightGrey.withValues(alpha: 0.3);
    }
  }

  Color _getStatusTextColor(String status, bool isDark) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'returned':
        return isDark ? Colors.greenAccent : AppColors.successDark;
      case 'approved':
      case 'active':
        return isDark ? AppColors.secondaryColor : AppColors.primaryColor;
      case 'pending':
        return isDark ? AppColors.amber : AppColors.amberDark;
      case 'rejected':
      case 'cancelled':
        return isDark ? Colors.redAccent : AppColors.error;
      default:
        return isDark ? AppColors.darkTextSecondary : AppColors.darkGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusBg = _getStatusBgColor(booking.status, isDark);
    final statusText = _getStatusTextColor(booking.status, isDark);
    final displayTitle = itemTitle ?? 'Booking #${booking.orderCode}';
    final displayImage =
        itemImageUrl ??
        'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=600';

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
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
                    color: isDark ? AppColors.darkContainer : AppColors.lightGrey,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: isDark ? AppColors.darkTextMuted : AppColors.grey,
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
                              color: isDark ? AppColors.darkTextPrimary : AppColors.black,
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
                      'Order Code: ${booking.orderCode}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.darkGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpace(4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 13.sp,
                          color: isDark ? AppColors.darkTextMuted : AppColors.grey,
                        ),
                        horizontalSpace(4),
                        Text(
                          '${booking.startDate} - ${booking.endDate}',
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            color: isDark ? AppColors.darkTextMuted : AppColors.grey,
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
          Divider(
            height: 1,
            color: isDark ? AppColors.darkDivider : AppColors.dividerColor,
          ),
          verticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.darkGrey,
                    ),
                  ),
                  Text(
                    '${booking.totalAmount} SAR',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              CustomButton(
                text: 'Order Details',
                width: 110.w,
                height: 38.h,
                fontSize: 12.5.sp,
                borderRadius: 10,
                onPressed: () {
                  context.pushNamed(
                    Routes.renterOrderDetailsScreen,
                    arguments: BookingSummaryArgs(
                      listingId: booking.listingId,
                      ownerId: booking.ownerId,
                      renterId: booking.renterId,
                      listingTitle: displayTitle,
                      listingImageUrl: displayImage,
                      dailyPrice: booking.dailyPrice,
                      securityDeposit: booking.securityDeposit,
                    ),
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
