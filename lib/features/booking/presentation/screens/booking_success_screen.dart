import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';

class BookingSuccessScreen extends StatelessWidget {
  final String orderCode;
  final BookingSummaryArgs? bookingArgs;

  const BookingSuccessScreen({
    super.key,
    this.orderCode = 'RNTR-0000',
    this.bookingArgs,
  });

  String _formatDateRange(DateTime? start, DateTime? end) {
    if (start == null || end == null) return '1 - 2 May';
    return '${start.day} - ${end.day} ${_getMonthName(end.month)}';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final safeArgs = bookingArgs ?? BookingSummaryArgs();
    final cubit = safeArgs.bookingCubit;
    final dailyPrice = safeArgs.dailyPrice.toDouble();
    final totalDays = cubit?.totalDays ?? 2;
    final securityDeposit = safeArgs.securityDeposit.toDouble();
    final serviceFee = double.parse((dailyPrice * 0.1).toStringAsFixed(2));
    final totalAmount = (dailyPrice * totalDays) + serviceFee + securityDeposit;
    final dateRange = _formatDateRange(cubit?.startDate, cubit?.endDate);

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace(24),
                  // Success Circle with Checkmark
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 48,
                    ),
                  ),
                  verticalSpace(16),
                  // Main Title
                  const Text(
                    'Booking Confirmed !',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(8),
                  // Subtitle
                  const Text(
                    "We've sent your booking request to the owner.",
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(24),
                  // Booking Info Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                safeArgs.listingImageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      width: 60,
                                      height: 60,
                                      color: AppColors.lightGrey,
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: AppColors.grey,
                                      ),
                                    ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    safeArgs.listingTitle,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  verticalSpace(4),
                                  Text(
                                    'Booking ID: $orderCode',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  verticalSpace(4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        size: 14,
                                        color: AppColors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        dateRange,
                                        style: const TextStyle(
                                          fontSize: 12,
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
                        Container(height: 1, color: AppColors.lightGrey),
                        verticalSpace(12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ),
                            Text(
                              '${totalAmount.toStringAsFixed(0)} SAR',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(24),
                  // What's Next Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F7F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "What's next",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(12),
                        _buildNextStep(
                          'The owner will review and confirm your request (usually within 2 hours).',
                        ),
                        verticalSpace(12),
                        _buildNextStep(
                          "We'll notify you on the status via email and in-app notification.",
                        ),
                        verticalSpace(12),
                        _buildNextStep(
                          "We'll confirm the payment after the request is confirmed as you can complete the payment.",
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(32),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: CustomButton(
                      text: 'View Booking Details',
                      onPressed: () {
                        context.pushNamed(
                          Routes.renterOrderDetailsScreen,
                          arguments: bookingArgs ?? BookingSummaryArgs(),
                        );
                      },
                    ),
                  ),
                  verticalSpace(12),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        context.pushReplacementNamed(Routes.onBoardingScreens);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextStep(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: AppColors.white, size: 12),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.primaryColor,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
