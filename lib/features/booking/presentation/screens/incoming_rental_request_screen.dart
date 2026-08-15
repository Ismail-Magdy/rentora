import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';
import 'package:rentora/features/booking/presentation/widgets/incoming_request_action_buttons.dart';
import 'package:rentora/features/booking/presentation/widgets/incoming_request_earnings_card.dart';
import 'package:rentora/features/booking/presentation/widgets/incoming_request_item_card.dart';
import 'package:rentora/features/booking/presentation/widgets/incoming_request_renter_card.dart';

class IncomingRentalRequestScreen extends StatelessWidget {
  final BookingModel? booking;

  const IncomingRentalRequestScreen({
    super.key,
    this.booking,
  });

  @override
  Widget build(BuildContext context) {
    try {
      BlocProvider.of<BookingCubit>(context);
      return _buildScreenContent(context);
    } catch (_) {
      return BlocProvider(
        create: (context) => getIt<BookingCubit>(),
        child: Builder(
          builder: (context) => _buildScreenContent(context),
        ),
      );
    }
  }

  Widget _buildScreenContent(BuildContext context) {
    final bookingId = booking?.bookingId ?? 'sample_booking_id';
    final title = booking != null
        ? 'Listing #${booking!.listingId}'
        : 'Canon EOS 250D DSLR Camera';
    final imageUrl =
        'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=600';
    final dateRange = (booking?.startDate != null && booking?.endDate != null)
        ? '${booking!.startDate} - ${booking!.endDate}'
        : '15 - 18 October';
    final durationText = '${booking?.totalDays ?? 3} days';
    final totalAmount = (booking?.totalAmount ?? 1350).toDouble();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const CustomAppBar(text: 'Rental Request'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Incoming Request',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              verticalSpace(4),
              Text(
                'Review the rental request details before accepting or rejecting.',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              verticalSpace(20),
              IncomingRequestItemCard(
                imageUrl: imageUrl,
                title: title,
                dateRange: dateRange,
                durationText: durationText,
              ),
              verticalSpace(16),
              const IncomingRequestRenterCard(
                renterName: 'Sara Ahmed',
                avatarUrl: 'https://i.pravatar.cc/150?img=47',
                rating: '4.8',
                reviewsCountText: '12 Rentals',
                isVerified: true,
              ),
              verticalSpace(16),
              IncomingRequestEarningsCard(
                totalAmount: totalAmount,
              ),
              verticalSpace(24),
              IncomingRequestActionButtons(
                bookingId: bookingId,
              ),
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
