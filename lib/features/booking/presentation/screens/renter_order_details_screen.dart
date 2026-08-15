import 'package:flutter/material.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';

class RenterOrderDetailsScreen extends StatelessWidget {
  final BookingSummaryArgs? args;

  const RenterOrderDetailsScreen({super.key, this.args});

  String _formatDate(DateTime? date) {
    if (date == null) return '1 May';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final safeArgs = args ?? BookingSummaryArgs();
    final cubit = safeArgs.bookingCubit ?? getIt<BookingCubit>();
    final totalDays = cubit.totalDays == 0 ? 2 : cubit.totalDays;
    final dailyPrice = safeArgs.dailyPrice.toDouble();
    final securityDeposit = safeArgs.securityDeposit.toDouble();
    final totalAmount = (dailyPrice * totalDays) + securityDeposit;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Booking Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      safeArgs.listingImageUrl,
                      width: 76,
                      height: 76,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 76,
                        height: 76,
                        color: AppColors.lightGrey,
                        child: const Icon(
                          Icons.camera_alt,
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
                        Text(
                          safeArgs.listingTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalSpace(6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'Booking request in progress',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Trip Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  verticalSpace(14),
                  _detailRow('Check-in', _formatDate(cubit.startDate)),
                  verticalSpace(12),
                  _detailRow('Check-out', _formatDate(cubit.endDate)),
                  verticalSpace(12),
                  _detailRow('Duration', '$totalDays days'),
                  verticalSpace(12),
                  _detailRow(
                    'Daily Price',
                    '${dailyPrice.toStringAsFixed(0)} SAR',
                  ),
                  verticalSpace(12),
                  _detailRow(
                    'Security Deposit',
                    '${securityDeposit.toStringAsFixed(0)} SAR',
                  ),
                  verticalSpace(12),
                  _detailRow('Total', '${totalAmount.toStringAsFixed(0)} SAR'),
                ],
              ),
            ),
            verticalSpace(16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F7F9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.info_outline,
                      color: AppColors.white,
                      size: 16,
                    ),
                  ),
                  horizontalSpace(12),
                  Expanded(
                    child: const Text(
                      'Owner review is pending. You will be notified once the request is approved.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.primaryColor,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
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

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
