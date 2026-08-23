import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class ItemDescriptionSection extends StatelessWidget {
  final String description;

  const ItemDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: .start,
      children: [
        //
        Text(
          l10n.description,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: .bold,
            color: isDark ? AppColors.darkTextPrimary : AppColors.black,
          ),
        ),
        //
        verticalSpace(8),
        //
        Text(
          description,
          style: TextStyle(
            fontSize: 14.sp,
            color: isDark ? AppColors.darkTextSecondary : AppColors.grey.withValues(alpha: 1.2),
            height: 1.5,
          ),
        ),
        //
      ],
    );
  }
}
