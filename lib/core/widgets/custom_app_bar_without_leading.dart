import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class CustomAppBarWithNoLeading extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithNoLeading({super.key, required this.text});
  final String text;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: SizedBox.shrink(),
      leadingWidth: 0,
      title: Text(
        text,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: .bold,
          fontSize: 18.sp,
        ),
      ),
      centerTitle: true,
    );
  }
}
