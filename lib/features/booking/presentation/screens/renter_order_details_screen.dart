import 'package:flutter/material.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';
import 'package:rentora/features/booking/presentation/widgets/info_notice_card.dart';
import 'package:rentora/features/booking/presentation/widgets/renter_order_header_card.dart';
import 'package:rentora/features/booking/presentation/widgets/trip_details_card.dart';

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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RenterOrderHeaderCard(
              imageUrl: safeArgs.listingImageUrl,
              title: safeArgs.listingTitle,
            ),
            verticalSpace(16),
            TripDetailsCard(
              checkIn: _formatDate(cubit.startDate),
              checkOut: _formatDate(cubit.endDate),
              duration: '$totalDays days',
              dailyPrice: '${dailyPrice.toStringAsFixed(0)} SAR',
              securityDeposit: '${securityDeposit.toStringAsFixed(0)} SAR',
              total: '${totalAmount.toStringAsFixed(0)} SAR',
            ),
            verticalSpace(16),
            const InfoNoticeCard(
              message:
                  'Owner review is pending. You will be notified once the request is approved.',
            ),
          ],
        ),
      ),
    );
  }
}
