import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_action_bar.dart';
import 'package:rentora/features/booking/presentation/widgets/info_notice_card.dart';
import 'package:rentora/features/booking/presentation/widgets/listing_info_card.dart';
import 'package:rentora/features/booking/presentation/widgets/payment_method_option_card.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class PaymentMethodScreen extends StatefulWidget {
  final BookingSummaryArgs args;

  const PaymentMethodScreen({super.key, required this.args});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dailyPrice = widget.args.dailyPrice.toDouble();
    final cubit = widget.args.bookingCubit ?? getIt<BookingCubit>();
    final totalDays = cubit.totalDays == 0 ? 2 : cubit.totalDays;
    final securityDeposit = widget.args.securityDeposit.toDouble();
    final serviceFee = double.parse((dailyPrice * 0.1).toStringAsFixed(2));
    final totalAmount = (dailyPrice * totalDays) + serviceFee + securityDeposit;

    return BlocListener<BookingCubit, BookingState>(
      listenWhen: (previous, current) =>
          current is BookingSuccess || current is BookingError,
      listener: (context, state) {
        if (state is BookingSuccess) {
          showFeedbackDialog(
            context,
            icon: Icons.check_circle_outline,
            color: AppColors.successDark,
            title: l10n.bookingConfirmedTitle,
            message: l10n.sentBookingRequestOwner,
            onFinish: () {
              context.pushReplacementNamed(
                Routes.bookingSuccessScreen,
                arguments: BookingSuccessArgs(
                  orderCode: state.orderCode,
                  bookingSummaryArgs: widget.args,
                ),
              );
            },
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
      child: _buildScaffold(
        context,
        l10n,
        dailyPrice,
        totalDays,
        securityDeposit,
        serviceFee,
        totalAmount,
        cubit,
      ),
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    AppLocalizations l10n,
    double dailyPrice,
    int totalDays,
    double securityDeposit,
    double serviceFee,
    double totalAmount,
    BookingCubit cubit,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(text: l10n.paymentMethod),
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
                Text(
                  l10n.choosePaymentMethod,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                  ),
                ),
                verticalSpace(16),
                PaymentMethodOptionCard(title: l10n.cash, isSelected: true),
                verticalSpace(24),
                InfoNoticeCard(
                  message: l10n.payAfterConfirmed,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BookingActionBar(
        label: l10n.total,
        totalText: '${totalAmount.toStringAsFixed(0)} ${l10n.sar}',
        buttonText: l10n.confirmPayment,
        buttonWidth: 170.w,
        onPressed: () {
          final firebaseAuthService = getIt<FirebaseAuthService>();
          final currentUserId =
              firebaseAuthService.getCurrentUserId() ?? widget.args.renterId;
          cubit.submitBooking(
            listingId: widget.args.listingId,
            ownerId: widget.args.ownerId,
            renterId: currentUserId,
            dailyPrice: widget.args.dailyPrice,
            securityDeposit: widget.args.securityDeposit,
          );
        },
      ),
    );
  }
}
