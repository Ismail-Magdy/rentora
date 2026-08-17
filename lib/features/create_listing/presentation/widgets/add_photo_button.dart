
import 'package:flutter/material.dart';
import 'package:rentora/core/themes/app_colors.dart';

class AddPhotoButton extends StatelessWidget {
   const AddPhotoButton({
    this.onTap,
  });
  final VoidCallback? onTap;

 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 105,
        height: 105,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryColor
                .withOpacity(.35),
            width: 1.5,
          ),
        ),
        child: const Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              color: AppColors.primaryColor,
              size: 27,
            ),
            SizedBox(height: 6),
            Text(
              'Add',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
