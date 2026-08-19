import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class ItemAvailabilitySection extends StatelessWidget {
  const ItemAvailabilitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        //
        Text(
          "Availability",
          style: TextStyle(fontSize: 16.sp, fontWeight: .bold),
        ),
        //
        verticalSpace(12),
        //
        Container(
          height: 200.h,
          width: .infinity,
          decoration: BoxDecoration(
            border: .all(color: AppColors.grey.withValues(alpha: 0.8)),
            borderRadius: .circular(12.r),
          ),
          child: Center(
            child: Text(
              "Calendar Widget Goes Here",
              style: TextStyle(color: AppColors.grey.withValues(alpha: 0.9)),
            ),
          ),
        ),
        //
      ],
    );
  }
}
