import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class ItemFeaturesSection extends StatelessWidget {
  final List<String> features;

  const ItemFeaturesSection({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          'Key Features',
          style: TextStyle(fontSize: 16.sp, fontWeight: .bold),
        ),
        verticalSpace(12),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: features.map((feature) {
            return Container(
              padding: .symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: .all(color: Colors.grey.shade200),
                borderRadius: .circular(8.r),
              ),
              child: Row(
                mainAxisSize: .min,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: AppColors.primaryColor,
                    size: 16.sp,
                  ),
                  horizontalSpace(8),
                  Text(feature, style: TextStyle(fontSize: 12.sp)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
