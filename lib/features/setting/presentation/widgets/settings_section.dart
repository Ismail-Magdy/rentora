import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == .dark;
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: .symmetric(horizontal: 20.w, vertical: 8.h),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: .w600,
              color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
            ),
          ),
        ),
        Container(
          margin: .symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.white,
            boxShadow: [
              BoxShadow(
                color: isDark ? AppColors.darkShadow : AppColors.lightGrey,
                blurRadius: 10.r,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: .circular(16.r),
          ),
          child: Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],

                if (i < children.length - 1)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: isDark ? AppColors.darkDivider : AppColors.lightGrey,
                  ),
              ],
            ],
          ),
        ),
        verticalSpace(16),
      ],
    );
  }
}
