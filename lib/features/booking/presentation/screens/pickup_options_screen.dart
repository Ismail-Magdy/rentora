import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_action_bar.dart';
import 'package:rentora/features/booking/presentation/widgets/info_notice_card.dart';
import 'package:rentora/features/booking/presentation/widgets/listing_info_card.dart';
import 'package:rentora/features/booking/presentation/widgets/pickup_location_card.dart';
import 'package:rentora/features/booking/presentation/widgets/pickup_option_card.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final dailyPrice = widget.args.dailyPrice.toDouble();
    final cubit = widget.args.bookingCubit ?? getIt<BookingCubit>();
    final totalDays = cubit.totalDays == 0 ? 2 : cubit.totalDays;
    final securityDeposit = widget.args.securityDeposit.toDouble();
    final serviceFee = double.parse((dailyPrice * 0.1).toStringAsFixed(2));
    final totalAmount = (dailyPrice * totalDays) + serviceFee + securityDeposit;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(text: l10n.pickupMethod),
      body: Column(
        children: [
          Expanded(
            child: ListView(
                padding: EdgeInsets.all(16.r),
                children: [
                ListingInfoCard(
                  title: widget.args.listingTitle,
                  imageUrl: widget.args.listingImageUrl,
                  dailyPrice: dailyPrice,
                ),
                verticalSpace(16),
                PickupLocationCard(
                  title: selectedMethod == 'pickup'
                      ? l10n.personalPickup
                      : l10n.homeDelivery,
                  address: l10n.meetOwnerLocation,
                  distance: l10n.free,
                ),
                verticalSpace(16),
                PickupOptionCard(
                  title: l10n.personalPickup,
                  subtitle: l10n.meetOwnerLocation,
                  isSelected: selectedMethod == 'pickup',
                  onTap: () => setState(() => selectedMethod = 'pickup'),
                ),
                verticalSpace(12),
                PickupOptionCard(
                  title: l10n.homeDelivery,
                  subtitle: l10n.safeDeliveryDoorstep,
                  isSelected: selectedMethod == 'delivery',
                  onTap: () => setState(() => selectedMethod = 'delivery'),
                ),
                verticalSpace(16),
                InfoNoticeCard(
                  message: selectedMethod == 'pickup'
                      ? l10n.pickupTimeNotice
                      : l10n.deliveryChargesNotice,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BookingActionBar(
        label: l10n.total,
        totalText: '${totalAmount.toStringAsFixed(0)} ${l10n.sar}',
        buttonText: l10n.confirmMethod,
        buttonWidth: 170.w,
        onPressed: () {
          context.pushNamed(Routes.paymentMethodScreen, arguments: widget.args);
        },
      ),
    );
  }
}
