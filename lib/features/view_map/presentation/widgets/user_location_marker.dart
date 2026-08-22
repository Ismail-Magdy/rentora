import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class UserLocationMarker extends StatelessWidget {
  final String firstName;

  const UserLocationMarker({super.key, required this.firstName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: .symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: .circular(8.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            firstName,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 12.sp,
              fontWeight: .bold,
            ),
          ),
        ),
        verticalSpace(4),
        Icon(Icons.location_on, color: AppColors.primaryColor, size: 32.sp),
      ],
    );
  }
}
