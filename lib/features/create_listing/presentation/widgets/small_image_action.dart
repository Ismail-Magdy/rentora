
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class SmallImageAction extends StatelessWidget {
   const SmallImageAction({
    required this.icon,
    required this.onTap,
    this.isDelete = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isDelete;

 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34.w,
        height: 34.h,
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 17.sp,
          color: isDelete
              ? AppColors.error
              : AppColors.darkGrey,
        ),
      ),
    );
  }
}
