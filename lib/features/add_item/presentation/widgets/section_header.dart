
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class SectionHeader extends StatelessWidget {
    const SectionHeader({
    required this.title,
    this.onEdit,
  });
  final String title;
  final VoidCallback? onEdit;



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
          ),
        ),

        if (onEdit != null)
          TextButton.icon(
            onPressed: onEdit,
            style: TextButton.styleFrom(
              foregroundColor:
                  AppColors.primaryColor,
              padding: EdgeInsets.zero,
            ),
            icon:  Icon(
              Icons.edit_outlined,
              size: 17.sp,
            ),
            label: const Text(
              'Edit',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
