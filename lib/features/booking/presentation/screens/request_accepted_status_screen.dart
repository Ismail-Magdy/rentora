import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/widgets/custom_app_bar_without_leading.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';
import 'package:rentora/features/booking/presentation/widgets/rental_request_status_actions.dart';
import 'package:rentora/features/booking/presentation/widgets/rental_request_status_card.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class RequestAcceptedStatusScreen extends StatelessWidget {
  final BookingModel? booking;

  const RequestAcceptedStatusScreen({super.key, this.booking});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBarWithNoLeading(text: l10n.rentalRequest),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            children: [
              const Spacer(),
              RentalRequestStatusCard(
                isAccepted: true,
                title: l10n.requestAccepted,
                message: l10n.requestAcceptedMessage,
                booking: booking,
              ),
              const Spacer(),
              const RentalRequestStatusActions(),
              verticalSpace(10),
            ],
          ),
        ),
      ),
    );
  }
}
