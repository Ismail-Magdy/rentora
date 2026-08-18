
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class ImageActionButton extends StatelessWidget {

  const ImageActionButton({
    required this.icon,
    required this.onTap,
    this.isDelete = false,
  });


  final IconData icon;
  final VoidCallback onTap;
  final bool isDelete;



  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 20.sp,
            color: isDelete
                ? AppColors.error
                : AppColors.darkGrey,
          ),
        ),
      ),
    );
  }
}
