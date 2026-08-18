


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class PriceRow extends StatelessWidget {
   const PriceRow({
    required this.label,
    required this.value,
    this.highlighted = false,
  });

  final String label;
  final String value;
  final bool highlighted;

 
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style:  TextStyle(
              fontSize: 13.sp,
              color: AppColors.grey,
            ),
          ),
        ),

        Text(
          value,
          style: TextStyle(
            fontSize: highlighted ? 18.sp : 15.sp,
            fontWeight: FontWeight.w800,
            color: highlighted
                ? AppColors.primaryColor
                : AppColors.darkGrey,
          ),
        ),
      ],
    );
  }
}
