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
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isAccepting
                  ? AppColors.primaryColor
                  : AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              'Confirm',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
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
              child: OutlinedButton(
                onPressed: () => _handleDecision(
                  context,
                  isAccepting: false,
                  title: 'Reject Request',
                  message:
                      'Are you sure you want to reject this rental request?',
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  side: const BorderSide(color: AppColors.error, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  'Reject',
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
