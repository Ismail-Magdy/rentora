import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';

class ItemBottomNavBar extends StatelessWidget {
  final ItemDetailsModel item;

  const ItemBottomNavBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            //
            Expanded(
              child: CustomButton(text: "Book Now", onPressed: () {}),
            ),
            //
            horizontalSpace(12),
            //
            Container(
              decoration: BoxDecoration(
                border: .all(color: Colors.grey.shade300),
                borderRadius: .circular(12.r),
              ),
              child: IconButton(
                icon: Icon(
                  item.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: item.isFavorite
                      ? AppColors.error
                      : AppColors.grey.withValues(alpha: 0.9),
                ),
                onPressed: () {},
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
