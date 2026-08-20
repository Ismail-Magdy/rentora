
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class DescriptionRow extends StatelessWidget {
    const DescriptionRow({
    required this.description,
  });

  final String description;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.grey,
          ),
        ),

        verticalSpace(7),

        Text(
          description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14.sp,
            height: 1.45.h,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
