import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: .symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          //
          GestureDetector(
            onTap: () {
              context.pushNamed(Routes.notificationsScreen);
            },
            child: Icon(
              Icons.notifications_outlined,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.secondaryColor,
              size: 29.sp,
            ),
          ),
          //
          horizontalSpace(15),
          // Search Bar
          Expanded(
            child: GestureDetector(
              onTap: () => context.pushNamed(Routes.searchScreen),

              child: Container(
                height: 45.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkSurface
                      : AppColors.grey.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : Colors.transparent,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: isDark ? AppColors.darkTextMuted : AppColors.grey,
                      size: 20.sp,
                    ),

                    horizontalSpace(8),

                    Expanded(
                      child: Text(
                        l10n.searchAnything,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isDark ? AppColors.darkTextMuted : AppColors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          horizontalSpace(25),
          //
          GestureDetector(
            onTap: () => context.pushNamed(Routes.favoritesScreen),
            child: SvgPicture.asset(
              "assets/svgs/home/heart_fill.svg",
              width: 28.w,
              height: 28.h,
            ),
          ),
          //
        ],
      ),
    );
  }
}
