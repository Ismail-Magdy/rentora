import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';

class OwnerInfoCard extends StatelessWidget {
  final ItemDetailsModel item;

  const OwnerInfoCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F9),
        borderRadius: .circular(12.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundImage: NetworkImage(item.ownerAvatar),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Text(
                      item.ownerName,
                      style: TextStyle(fontSize: 14.sp, fontWeight: .bold),
                    ),
                    horizontalSpace(4),
                    if (item.isSuperHost)
                      Icon(
                        Icons.verified,
                        color: AppColors.primaryColor,
                        size: 14.sp,
                      ),
                  ],
                ),
                verticalSpace(4),
                Row(
                  children: [
                    Text(
                      'Rental Confirmed',
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                    horizontalSpace(8),
                    Text(
                      item.ownerRating.toString(),
                      style: TextStyle(fontSize: 10.sp, fontWeight: .bold),
                    ),
                    Icon(Icons.star, color: Colors.orange, size: 10.sp),
                  ],
                ),
              ],
            ),
          ),

          //
          CustomButton(
            borderRadius: 10,
            text: "Contact",
            width: 100,
            height: 41,
            onPressed: () {},
          ),

          //
        ],
      ),
    );
  }
}
