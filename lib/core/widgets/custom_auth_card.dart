import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({super.key, this.title, required this.children, this.footer});

  final String? title;
  final List<Widget> children;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      shadowColor: AppColors.darkGrey,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),

      margin: EdgeInsets.symmetric(horizontal: 28.w),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) ...[
              Center(
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],

            ...children,

            if (footer != null) ...[
              SizedBox(height: 20.h),
              const Divider(height: 1),
              SizedBox(height: 16.h),
              Center(child: footer!),
            ],
          ],
        ),
      ),
    );
  }
}
