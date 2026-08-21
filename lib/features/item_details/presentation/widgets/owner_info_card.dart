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
            backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
            backgroundImage: item.ownerAvatar.isNotEmpty ? NetworkImage(item.ownerAvatar) : null,
            child: item.ownerAvatar.isEmpty
                ? Icon(Icons.person, color: AppColors.primaryColor)
                : null,
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      item.ownerName.isNotEmpty ? item.ownerName : 'Unknown Owner',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    if (item.ownerVerificationStatus == 'verified') ...[
                      horizontalSpace(4),
                      Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 18.sp,
                      ),
                    ],
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
