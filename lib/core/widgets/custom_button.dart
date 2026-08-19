import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:rentora/core/helpers/spacing.dart";
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
  final IconData? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;

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
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
        side: borderColor != null
            ? BorderSide(color: borderColor!, width: 1.5.w)
            : BorderSide.none,
      ),
      child: isLoading
          ? SizedBox(
              height: 24.h,
              width: 24.h,
              child: CupertinoActivityIndicator(color: textColor),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  horizontalSpace(8),
                ] else if (icon != null) ...[
                  Icon(icon, color: textColor, size: (fontSize ?? 16.sp) + 2),
                  horizontalSpace(8),
                ],
                Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize ?? 16.sp,
                    fontWeight: fontWeight,
                  ),
                ),
                if (suffixIcon != null) ...[horizontalSpace(8), suffixIcon!],
              ],
            ),
    );
  }
}
