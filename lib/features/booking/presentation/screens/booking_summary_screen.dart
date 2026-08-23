import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_action_bar.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_period_card.dart';
import 'package:rentora/features/booking/presentation/widgets/listing_info_card.dart';
import 'package:rentora/features/booking/presentation/widgets/price_details_card.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class BookingSummaryScreen extends StatelessWidget {
  final BookingSummaryArgs args;

  const BookingSummaryScreen({super.key, required this.args});

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select date';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = args.bookingCubit ?? getIt<BookingCubit>();
    final totalDays = cubit.totalDays == 0 ? 2 : cubit.totalDays;
    final dailyPrice = args.dailyPrice.toDouble();
    final securityDeposit = args.securityDeposit.toDouble();
    final serviceFee = double.parse((dailyPrice * 0.1).toStringAsFixed(2));
    final totalAmount = (dailyPrice * totalDays) + serviceFee + securityDeposit;

    return BlocListener<BookingCubit, BookingState>(
      listenWhen: (previous, current) =>
          current is BookingSuccess || current is BookingError,
      listener: (context, state) {
        if (state is BookingSuccess) {
          context.pushNamed(
            Routes.bookingSuccessScreen,
            arguments: BookingSuccessArgs(
              orderCode: state.orderCode,
              bookingSummaryArgs: args,
            ),
          );
        }

        if (state is BookingError) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline,
            color: AppColors.error,
            title: l10n.bookingFailed,
            message: state.message,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(text: l10n.bookingSummary),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.r),
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
                    totalDays: '$totalDays ${l10n.days}',
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
              label: l10n.total,
              totalText: '${totalAmount.toStringAsFixed(0)} ${l10n.sar}',
              buttonText: l10n.sendRentalRequest,
              buttonWidth: 170.w,
              onPressed: () {
                context.pushNamed(Routes.pickupOptionsScreen, arguments: args);
              },
            ),
          ],
        ),
      ),
    );
  }
}
