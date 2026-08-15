import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_action_bar.dart';
import 'package:rentora/features/booking/presentation/widgets/listing_info_card.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';

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
    final dailyPrice = widget.args.dailyPrice.toDouble();
    final cubit = widget.args.bookingCubit ?? getIt<BookingCubit>();
    final totalDays = cubit.totalDays == 0 ? 2 : cubit.totalDays;
    final securityDeposit = widget.args.securityDeposit.toDouble();
    final serviceFee = double.parse((dailyPrice * 0.1).toStringAsFixed(2));
    final totalAmount = (dailyPrice * totalDays) + serviceFee + securityDeposit;

    return BlocListener<BookingCubit, BookingState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is BookingSuccess) {
          showFeedbackDialog(
            context,
            icon: Icons.check_circle_outline,
            color: AppColors.successDark,
            title: 'Booking Confirmed!',
            message: 'Your booking request has been sent successfully.',
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
            title: 'Booking Failed',
            message: state.message,
          );
        }
      },
      child: _buildScaffold(
        context,
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
    double dailyPrice,
    int totalDays,
    double securityDeposit,
    double serviceFee,
    double totalAmount,
    BookingCubit cubit,
  ) {
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
          'Payment Method',
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
                const Text(
                  'Choose a payment method',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                verticalSpace(16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Cash',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(24),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F7F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'You will pay the amount after the request is confirmed.',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BookingActionBar(
        label: 'Total',
        totalText: '${totalAmount.toStringAsFixed(0)} SAR',
        buttonText: 'Confirm Payment',
        buttonWidth: 170,
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
