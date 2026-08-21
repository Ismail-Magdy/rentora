import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class SearchRecent extends StatelessWidget {
  final List<String> searches;
  final ValueChanged<String> onSearchTap;

  const SearchRecent({
    super.key,
    required this.searches,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    if (searches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Searches',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),

        verticalSpace(8),

        ...searches.map(
          (search) => Column(
            children: [
              InkWell(
                onTap: () {
                  onSearchTap(search);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.history_rounded,
                        color: AppColors.darkGrey,
                        size: 22.sp,
                      ),

                      horizontalSpace(14),

                      Expanded(
                        child: Text(
                          search,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ),

                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16.sp,
                        color: AppColors.darkGrey,
                      ),
                    ],
                  ),
                ),
              ),

              Divider(
                color: AppColors.dividerColor,
                height: 1.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}