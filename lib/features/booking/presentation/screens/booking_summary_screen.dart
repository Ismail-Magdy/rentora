import 'package:flutter/material.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_action_bar.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_period_card.dart';
import 'package:rentora/features/booking/presentation/widgets/listing_info_card.dart';
import 'package:rentora/features/booking/presentation/widgets/price_details_card.dart';

class BookingSummaryScreen extends StatelessWidget {
  final BookingSummaryArgs args;

  const BookingSummaryScreen({super.key, required this.args});

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select date';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = args.bookingCubit ?? getIt<BookingCubit>();
    final totalDays = cubit.totalDays == 0 ? 2 : cubit.totalDays;
    final dailyPrice = args.dailyPrice.toDouble();
    final securityDeposit = args.securityDeposit.toDouble();
    final serviceFee = double.parse((dailyPrice * 0.1).toStringAsFixed(2));
    final totalAmount = (dailyPrice * totalDays) + serviceFee + securityDeposit;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Booking Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ListingInfoCard(
                  title: args.listingTitle,
                  imageUrl: args.listingImageUrl,
                  dailyPrice: dailyPrice,
                ),
                verticalSpace(16),
                BookingPeriodCard(
                  startDate: _formatDate(cubit.startDate),
                  endDate: _formatDate(cubit.endDate),
                  totalDays: '$totalDays days',
                ),
                verticalSpace(16),
                PriceDetailsCard(
                  dailyPrice: dailyPrice,
                  totalDays: totalDays,
                  serviceFee: serviceFee,
                  securityDeposit: securityDeposit,
                ),
              ],
            ),
          ),
          BookingActionBar(
            label: 'Total Due',
            totalText: '${totalAmount.toStringAsFixed(0)} SAR',
            buttonText: 'Send Rental Request',
            buttonWidth: 170,
            onPressed: () {
              context.pushNamed(Routes.pickupOptionsScreen, arguments: args);
            },
          ),
        ],
      ),
    );
  }
}
