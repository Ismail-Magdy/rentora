import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.text, this.actions});
  final String text;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return AppBar(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => context.pop(),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: isDark ? AppColors.darkTextPrimary : AppColors.primaryColor,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: isDark ? AppColors.darkTextPrimary : AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }
}
