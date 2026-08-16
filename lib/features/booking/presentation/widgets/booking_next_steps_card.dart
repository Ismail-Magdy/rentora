import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class BookingNextStepsCard extends StatelessWidget {
  final List<String> steps;

  const BookingNextStepsCard({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.primaryColor,
                size: 20.r,
              ),
              horizontalSpace(8),
              Text(
                "What's next",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          verticalSpace(12),
          for (final step in steps) ...[
            _buildNextStep(step),
            verticalSpace(12),
          ],
        ],
      ),
    );
  }

  Widget _buildNextStep(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20.w,
          height: 20.h,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, color: AppColors.white, size: 12.r),
        ),
        horizontalSpace(12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.primaryColor,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
