import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class ItemDescriptionSection extends StatelessWidget {
  final String description;

  const ItemDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        //
        Text(
          "Description",
          style: TextStyle(fontSize: 16.sp, fontWeight: .bold),
        ),
        //
        verticalSpace(8),
        //
        Text(
          description,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.grey.withValues(alpha: 1.2),
            height: 1.5,
          ),
        ),
        //
      ],
    );
  }
}
