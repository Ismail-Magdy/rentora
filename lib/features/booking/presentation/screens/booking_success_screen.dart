import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_next_steps_card.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_success_actions_bar.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_success_details_card.dart';

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
                  const Text(
                    "We've sent your booking request to the owner.",
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(24),
                  BookingSuccessDetailsCard(
                    listingTitle: safeArgs.listingTitle,
                    listingImageUrl: safeArgs.listingImageUrl,
                    orderCode: orderCode,
                    dateRange: dateRange,
                    totalAmount: totalAmount.toStringAsFixed(0),
                  ),
                  verticalSpace(24),
                  BookingNextStepsCard(
                    steps: const [
                      'The owner will review and confirm your request (usually within 2 hours).',
                      "We'll notify you on the status via email and in-app notification.",
                      "We'll confirm the payment after the request is confirmed as you can complete the payment.",
                    ],
                  ),
                  verticalSpace(32),
                ],
              ),
            ),
          ),
          BookingSuccessActionsBar(
            onViewDetails: () {
              context.pushNamed(
                Routes.renterOrderDetailsScreen,
                arguments: bookingArgs ?? BookingSummaryArgs(),
              );
            },
            onBackToHome: () {
              context.pushReplacementNamed(Routes.homeScreen);
            },
          ),
        ],
      ),
    );
  }
}
