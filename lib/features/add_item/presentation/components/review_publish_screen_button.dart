import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/add_item/manager/add_item_state.dart';

class ReviewPublishScreenButton extends StatelessWidget {
  const ReviewPublishScreenButton({
    super.key,
    required this.isDark,
    required this.state,
    required this.isPublishing,
  });

  final bool isDark;
  final AddItemState state;
  final bool isPublishing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : const Color(0xFFF8FAFA),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppColors.darkShadow
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: .infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: state.agreedToTerms && !isPublishing
              ? () => _publishListing(context)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            disabledBackgroundColor: AppColors.primaryColor.withValues(
              alpha: 0.6,
            ),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: isPublishing
              ? const SizedBox(
                  width: 23,
                  height: 23,
                  child: CupertinoActivityIndicator(color: AppColors.white),
                )
              : Text(
                  'Publish Listing',
                  style: TextStyle(fontSize: 17, fontWeight: .w800),
                ),
        ),
      ),
    );
  }

  void _publishListing(BuildContext context) {
    final state = context.read<AddItemCubit>().state;
    if (state.location.isEmpty) {
      showFeedbackDialog(
        context,
        icon: Icons.location_off_outlined,
        color: AppColors.warning,
        title: 'Location Required',
        message:
            'Please tap "Use your current location" to attach your default address before publishing.',
      );
      return;
    }
    context.read<AddItemCubit>().publishListing();
  }
}
