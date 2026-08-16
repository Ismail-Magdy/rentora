import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          //
          Icon(Icons.tune, color: AppColors.secondaryColor, size: 27.sp),
          //
          horizontalSpace(15),
          // Search Bar
          Expanded(
            child: Container(
              height: 45.h,
              padding: .symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.grey.withValues(alpha: 0.2),
                borderRadius: .circular(24.r),
              ),
              child: Row(
                children: [
                  //
                  Icon(Icons.search, color: AppColors.grey, size: 20.sp),
                  //
                  horizontalSpace(8),
                  //
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for anything",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey,
                        ),
                        border: .none,
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //
          horizontalSpace(35),
          //
          SvgPicture.asset(
            "assets/svgs/home/heart_fill.svg",
            width: 28.w,
            height: 28.h,
          ),
          //
        ],
      ),
    );
  }
}
