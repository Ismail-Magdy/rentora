import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class PriceRangeFields extends StatelessWidget {
  final TextEditingController minController;
  final TextEditingController maxController;

  final ValueChanged<String>? onMinChanged;
  final ValueChanged<String>? onMaxChanged;

  const PriceRangeFields({
    super.key,
    required this.minController,
    required this.maxController,
    this.onMinChanged,
    this.onMaxChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: _PriceField(
            controller: minController,
            hint: l10n.minPrice,
            onChanged: onMinChanged,
          ),
        ),

        horizontalSpace(12),
        Expanded(
          child: _PriceField(
            controller: maxController,
            hint: l10n.maxPrice,
            onChanged: onMaxChanged,
          ),
        ),
      ],
    );
  }
}

class _PriceField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;

  const _PriceField({
    required this.controller,
    required this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.darkTextPrimary : AppColors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 13.sp,
          color: isDark ? AppColors.darkTextMuted : AppColors.darkGrey,
        ),
        prefixIcon: Icon(
          Icons.currency_exchange_rounded,
          size: 19.sp,
          color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
        ),
        filled: true,
        fillColor: isDark ? AppColors.darkSurface : AppColors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
