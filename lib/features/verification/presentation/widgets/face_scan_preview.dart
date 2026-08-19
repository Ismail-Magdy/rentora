import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class FaceScanPreview extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;
  final bool isVerifying;

  const FaceScanPreview({
    super.key,
    required this.imageFile,
    required this.onTap,
    this.isVerifying = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 228.w,
            height: 228.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor, width: 5.w),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: ClipOval(
                child: imageFile != null
                    ? Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Container(
                        color: AppColors.verificationSurface,
                        child: Center(
                          child: Container(
                            width: 118.w,
                            height: 158.h,
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.verificationBorder,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withValues(
                                    alpha: 0.06,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Verify by Rentora",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                verticalSpace(8),
                                Container(
                                  width: 72.w,
                                  height: 72.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.infoLight,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 2.w,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.person_outline_rounded,
                                    color: AppColors.primaryColor,
                                    size: 42.sp,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 76.w,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.verificationBorder,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                verticalSpace(5),
                                Container(
                                  width: 54.w,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.verificationBorder,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                verticalSpace(6),
                                Text(
                                  "Place your face inside the circle.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 7.sp,
                                    color: AppColors.darkGrey,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
        verticalSpace(24),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.primaryColor.withValues(alpha: 0.12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isVerifying
                      ? Icons.autorenew
                      : (imageFile != null
                            ? Icons.check_circle_outline
                            : Icons.camera_alt_outlined),
                  size: 14.sp,
                  color: AppColors.primaryColor,
                ),
                horizontalSpace(7),
                Text(
                  isVerifying
                      ? "Verifying..."
                      : (imageFile != null ? "Verified" : "Tap to Scan"),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
