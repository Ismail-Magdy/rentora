
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/features/create_listing/presentation/widgets/small_image_action.dart';

class AdditionalPhotoCard extends StatelessWidget {
  final XFile image;
  final VoidCallback onRemove;
  final VoidCallback onEdit;

  const AdditionalPhotoCard({
    required this.image,
    required this.onRemove,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(image.path),
            fit: BoxFit.cover,
          ),

          Positioned(
            top: 8,
            right: 8,
            child: Row(
              children: [
                SmallImageAction(
                  icon: Icons.edit_outlined,
                  onTap: onEdit,
                ),
               horizontalSpace(8),
                SmallImageAction(
                  icon: Icons.delete_outline,
                  onTap: onRemove,
                  isDelete: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 