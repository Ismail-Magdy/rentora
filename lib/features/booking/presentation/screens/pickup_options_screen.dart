import 'package:flutter/material.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_action_bar.dart';
import 'package:rentora/features/booking/presentation/widgets/info_notice_card.dart';
import 'package:rentora/features/booking/presentation/widgets/listing_info_card.dart';
import 'package:rentora/features/booking/presentation/widgets/pickup_location_card.dart';
import 'package:rentora/features/booking/presentation/widgets/pickup_option_card.dart';

class PickupOptionsScreen extends StatefulWidget {
  final BookingSummaryArgs args;

  const PickupOptionsScreen({super.key, required this.args});

  @override
  State<PickupOptionsScreen> createState() => _PickupOptionsScreenState();
}

class _PickupOptionsScreenState extends State<PickupOptionsScreen> {
  String selectedMethod = 'pickup';
  bool agreeToTerms = true;

  @override
  Widget build(BuildContext context) {
    final dailyPrice = widget.args.dailyPrice.toDouble();
    final cubit = widget.args.bookingCubit ?? getIt<BookingCubit>();
    final totalDays = cubit.totalDays == 0 ? 2 : cubit.totalDays;
    final securityDeposit = widget.args.securityDeposit.toDouble();
    final serviceFee = double.parse((dailyPrice * 0.1).toStringAsFixed(2));
    final totalAmount = (dailyPrice * totalDays) + serviceFee + securityDeposit;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Pickup Method',
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
                  title: widget.args.listingTitle,
                  imageUrl: widget.args.listingImageUrl,
                  dailyPrice: dailyPrice,
                ),
                verticalSpace(16),
                PickupLocationCard(
                  title: selectedMethod == 'pickup'
                      ? 'Personal pickup'
                      : 'Home delivery',
                  address: 'Meet the owner at a specific location',
                  distance: 'Free',
                ),
                verticalSpace(16),
                PickupOptionCard(
                  title: 'Personal pickup',
                  subtitle: 'Meet the owner at a specific location',
                  isSelected: selectedMethod == 'pickup',
                  onTap: () => setState(() => selectedMethod = 'pickup'),
                ),
                verticalSpace(12),
                PickupOptionCard(
                  title: 'Home delivery',
                  subtitle: 'Safe delivery to your doorstep',
                  isSelected: selectedMethod == 'delivery',
                  onTap: () => setState(() => selectedMethod = 'delivery'),
                ),
                verticalSpace(16),
                InfoNoticeCard(
                  message: selectedMethod == 'pickup'
                      ? 'The exact pickup time will be arranged with the owner after your request is confirmed.'
                      : 'Delivery charges may apply and will be confirmed after your request is approved.',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BookingActionBar(
        label: 'Total',
        totalText: '${totalAmount.toStringAsFixed(0)} SAR',
        buttonText: 'Confirm Method',
        buttonWidth: 170,
        onPressed: () {
          context.pushNamed(Routes.paymentMethodScreen, arguments: widget.args);
        },
      ),
    );
  }
}
