import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class TripDetailsCard extends StatelessWidget {
  final String checkIn;
  final String checkOut;
  final String duration;
  final String dailyPrice;
  final String securityDeposit;
  final String total;

  const TripDetailsCard({
    super.key,
    required this.checkIn,
    required this.checkOut,
    required this.duration,
    required this.dailyPrice,
    required this.securityDeposit,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppColors.darkShadow
                : AppColors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.priceDetails,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
            ),
          ),
          verticalSpace(14),
          _detailRow(l10n.days, duration, isDark),
          verticalSpace(12),
          _detailRow(l10n.dailyPrice, dailyPrice, isDark),
          verticalSpace(12),
          _detailRow(l10n.securityDepositLabel, securityDeposit, isDark),
          verticalSpace(12),
          _detailRow(l10n.total, total, isDark),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkTextPrimary : AppColors.black,
          ),
        ),
      ],
    );
  }
}
