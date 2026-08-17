


import 'package:flutter/material.dart';
import 'package:rentora/core/themes/app_colors.dart';


class MainPhotoEmpty extends StatelessWidget {
  final VoidCallback onTap;

  const MainPhotoEmpty({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 210,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFD9E0E1),
          ),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: AppColors.primaryColor
                    .withOpacity(.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_a_photo_outlined,
                color: AppColors.primaryColor,
                size: 29,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Add main photo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Choose a clear photo of your item',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF7A8184),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
