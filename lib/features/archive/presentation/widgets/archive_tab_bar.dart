import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class ArchiveTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;

  const ArchiveTabBar({
    super.key,
    required this.tabController,
    this.tabs = const ['My Rentals', 'My Listings'],
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localizedTabs = [l10n.myRentals, l10n.myListings];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppColors.darkShadow
                : AppColors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: [
            BoxShadow(
              color: (isDark
                      ? AppColors.secondaryColor
                      : AppColors.primaryColor)
                  .withValues(alpha: 0.25),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: AppColors.white,
        unselectedLabelColor: isDark ? AppColors.darkTextSecondary : AppColors.darkGrey,
        labelStyle: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w500,
        ),
        tabs: localizedTabs.map((tabTitle) => Tab(text: tabTitle)).toList(),
      ),
    );
  }
}
