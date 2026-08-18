import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';

class ItemInfoSection extends StatelessWidget {
  final ItemDetailsModel item;

  const ItemInfoSection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .start,
          children: [
            //
            Expanded(
              child: Text(
                item.name,
                style: TextStyle(fontSize: 22.sp, fontWeight: .bold),
              ),
            ),
            //
            Container(
              padding: .symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: .circular(12.r),
              ),
              child: Row(
                children: [
                  //
                  Text(
                    item.rating.toStringAsFixed(1),
                    style: TextStyle(fontSize: 12.sp, fontWeight: .bold),
                  ),
                  //
                  horizontalSpace(4),
                  //
                  Icon(Icons.star, color: AppColors.warning, size: 14.sp),
                  //
                ],
              ),
            ),
            //
          ],
        ),
        verticalSpace(12),
        //
        Row(
          crossAxisAlignment: .baseline,
          textBaseline: .alphabetic,
          children: [
            //
            Text(
              '${item.price.toInt()}',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: .bold,
                color: AppColors.primaryColor,
              ),
            ),
            //
            Text(
              ' LE / day',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: .bold,
                color: AppColors.primaryColor,
              ),
            ),
            //
          ],
        ),
        verticalSpace(20),
        //
        Container(
          padding: .all(12.r),
          decoration: BoxDecoration(
            border: .all(color: AppColors.grey.withValues(alpha: 0.2)),
            borderRadius: .circular(12.r),
          ),
          child: Row(
            children: [
              //
              Icon(
                Icons.location_on_outlined,
                color: AppColors.error,
                size: 24.sp,
              ),
              //
              horizontalSpace(12),
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(fontSize: 14.sp, fontWeight: .bold),
                    ),
                    Text(
                      '${item.locationName} (${item.distance} km)',
                      style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: AppColors.grey, size: 16.sp),
            ],
          ),
        ),
      ],
    );
  }
}
