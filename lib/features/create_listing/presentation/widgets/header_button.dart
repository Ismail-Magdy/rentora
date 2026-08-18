
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';


class HeaderButton extends StatelessWidget {
    const HeaderButton({
    required this.icon,
    required this.onTap,
    
  });
  final IconData icon;
  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42.w,
        height: 42.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.white,
          ),
        ),
        child: Icon(
          icon,
          color: AppColors.darkGrey,
          size: 22.sp,
        ),
      ),
    );
  }
}