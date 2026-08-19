import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar_without_leading.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';
import 'package:rentora/features/booking/presentation/widgets/rental_request_status_actions.dart';
import 'package:rentora/features/booking/presentation/widgets/rental_request_status_card.dart';

class RequestAcceptedStatusScreen extends StatelessWidget {
  final BookingModel? booking;

  const RequestAcceptedStatusScreen({super.key, this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const CustomAppBarWithNoLeading(text: 'Request Status'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            children: [
              const Spacer(),
              RentalRequestStatusCard(
                isAccepted: true,
                title: 'Request Accepted',
                message:
                    'The rental request has been approved successfully.\nThe renter has been notified.',
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
