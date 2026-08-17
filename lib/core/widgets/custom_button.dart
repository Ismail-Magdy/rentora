import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:rentora/core/themes/app_colors.dart";

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? elevation;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.borderRadius = 14.0,
    this.color,
    this.textColor = Colors.white,
    this.fontSize,
    this.fontWeight = .bold,
    this.elevation = 0,

    this.borderColor,
    this.borderWidth,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color ?? AppColors.primaryColor,
      minWidth: width ?? .infinity,
      height: height ?? 50.h,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(borderRadius.r),
        side: BorderSide(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 0,
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            SizedBox(width: 10.w), // مسافة بين اللوجو والنص
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize ?? 16.sp,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
