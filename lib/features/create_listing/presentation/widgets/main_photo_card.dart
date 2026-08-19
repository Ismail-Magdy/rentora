





import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/create_listing/presentation/widgets/image_action_button.dart';

class MainPhotoCard extends StatelessWidget {
  final XFile image;
  final VoidCallback onRemove;
  final VoidCallback onEdit;

  const MainPhotoCard({
    required this.image,
    required this.onRemove,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 210.h,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(image.path),
              fit: BoxFit.cover,
            ),

            // Gradient
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withOpacity(.15),
                    AppColors.darkGrey.withOpacity(.15),
                    AppColors.black.withOpacity(.55),
                  ],
                ),
              ),
            ),

            // Main Badge
            Positioned(
              left: 12,
              bottom: 12,
              child: Container(
                padding:
                     EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 7.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child:  Text(
                  'Main photo',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            // Actions
            Positioned(
              top: 12,
              right: 12,
              child: Row(
                children: [
                  ImageActionButton(
                    icon: Icons.edit_outlined,
                    onTap: onEdit,
                  ),
                
                  horizontalSpace(8),
                  ImageActionButton(
                    icon: Icons.delete_outline,
                    onTap: onRemove,
                    isDelete: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

