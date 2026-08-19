import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.lightGrey)),
        Padding(
          padding: .symmetric(horizontal: 16.w),
          child: Text(
            "Or",
            style: TextStyle(color: AppColors.darkGrey, fontSize: 16.sp),
          ),
        ),
        Expanded(child: Divider(color: AppColors.lightGrey)),
      ],
    );
  }
}
