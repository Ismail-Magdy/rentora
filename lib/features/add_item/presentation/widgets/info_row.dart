import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.valueBold = false,
  });

  final String label;
  final String value;
  final bool valueBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 13.sp, color: AppColors.grey),
          ),
        ),

        horizontalSpace(8),

        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: .right,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: valueBold ? .w800 : .w600,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
