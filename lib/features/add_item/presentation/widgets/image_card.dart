
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  final VoidCallback onRemove;

  const ImageCard({
    required this.imagePath,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            width: 130.w,
            height: 120.h,
            fit: BoxFit.cover,

            errorBuilder: (_, __, ___) {
              return Container(
                width: 130.w,
                height: 120.h,
                color: AppColors.lightGrey,
                child: const Icon(
                  Icons.image_outlined,
                  size: 38,
                  color: AppColors.primaryColor,
                ),
              );
            },
          ),
        ),

        Positioned(
          top: 7,
          right: 7,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 18,
                color: AppColors.error,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
