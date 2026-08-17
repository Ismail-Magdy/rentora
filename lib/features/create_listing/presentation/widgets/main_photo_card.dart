





import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
        height: 210,
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
                    Colors.black.withOpacity(.15),
                    Colors.transparent,
                    Colors.black.withOpacity(.55),
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
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: const Text(
                  'Main photo',
                  style: TextStyle(
                    fontSize: 12,
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
                  const SizedBox(width: 8),
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

