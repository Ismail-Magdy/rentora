import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:rentora/core/themes/app_colors.dart";

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? elevation;
  final bool isLoading;

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
    this.fontWeight = FontWeight.bold,
    this.elevation = 0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isLoading ? null : onPressed,
      color: color ?? AppColors.primaryColor,
      disabledColor: (color ?? AppColors.primaryColor).withValues(alpha: 0.5),
      minWidth: width ?? .infinity,
      height: height ?? 50.h,
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: .circular(borderRadius.r)),
      child: isLoading
          ? SizedBox(
              height: 24.h,
              width: 24.h,
              child: CupertinoActivityIndicator(color: textColor),
            )
          : Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize ?? 16.sp,
                fontWeight: fontWeight,
              ),
            ),
    );
  }
}
