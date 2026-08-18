
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class AddPhotoCard extends StatelessWidget {

    const AddPhotoCard({
    required this.onTap,
  });
  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFCBD6D8),
            width: 1.5.w,
          ),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
             Icon(
              Icons.add_a_photo_outlined,
              color: AppColors.primaryColor,
              size: 30,
            ),
            verticalSpace(8),
            Text(
              'Add photo',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
