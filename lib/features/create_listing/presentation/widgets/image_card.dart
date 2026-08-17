
import 'package:flutter/material.dart';

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
            width: 130,
            height: 120,
            fit: BoxFit.cover,

            errorBuilder: (_, __, ___) {
              return Container(
                width: 130,
                height: 120,
                color: const Color(0xFFE8EFF0),
                child: const Icon(
                  Icons.image_outlined,
                  size: 38,
                  color: Color(0xFF008B9B),
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
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 18,
                color: Color(0xFFD64545),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
