import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';

class ItemAvailabilitySection extends StatelessWidget {
  const ItemAvailabilitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          "Availability",
          style: TextStyle(fontSize: 16.sp, fontWeight: .bold),
        ),
        verticalSpace(12),
        Container(
          height: 200.h,
          width: .infinity,
          decoration: BoxDecoration(
            border: .all(color: Colors.grey.shade200),
            borderRadius: .circular(12.r),
          ),
          child: Center(
            child: Text(
              'Calendar Widget Goes Here',
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
        ),
      ],
    );
  }
}
