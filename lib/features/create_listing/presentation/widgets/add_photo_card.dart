
import 'package:flutter/material.dart';
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
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_a_photo_outlined,
              color: AppColors.primaryColor,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              'Add photo',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
