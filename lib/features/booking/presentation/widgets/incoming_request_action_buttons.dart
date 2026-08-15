import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';

class IncomingRequestActionButtons extends StatelessWidget {
  final String bookingId;

  const IncomingRequestActionButtons({super.key, required this.bookingId});

  Future<void> _handleDecision(
    BuildContext context, {
    required bool isAccepting,
    required String title,
    required String message,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: AppColors.white,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(fontSize: 14.sp, color: AppColors.darkGrey),
        ),
        actions: [
          CustomButton(
            text: 'Cancel',
            width: 80.w,
            height: 38.h,
            color: Colors.transparent,
            textColor: AppColors.grey,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
          CustomButton(
            text: 'Confirm',
            width: 90.w,
            height: 38.h,
            borderRadius: 8,
            color: isAccepting ? AppColors.primaryColor : AppColors.error,
            textColor: AppColors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final newStatus = isAccepting ? 'accepted' : 'rejected';
      context.read<BookingCubit>().updateBookingStatus(
        bookingId: bookingId,
        status: newStatus,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingStatusUpdated) {
          final targetRoute = state.status == 'accepted'
              ? Routes.requestAcceptedStatusScreen
              : Routes.requestRejectedStatusScreen;
          context.pushReplacementNamed(targetRoute);
        } else if (state is BookingError) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline,
            color: AppColors.error,
            title: 'Action Failed',
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is BookingLoading;

        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        return Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Reject',
                color: AppColors.white,
                textColor: AppColors.error,
                height: 48.h,
                fontSize: 15.sp,
                borderRadius: 14,
                onPressed: () => _handleDecision(
                  context,
                  isAccepting: false,
                  title: 'Reject Request',
                  message:
                      'Are you sure you want to reject this rental request?',
                ),
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: CustomButton(
                text: 'Accept Request',
                height: 48.h,
                fontSize: 15.sp,
                onPressed: () => _handleDecision(
                  context,
                  isAccepting: true,
                  title: 'Accept Request',
                  message:
                      'Are you sure you want to accept this rental request?',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
