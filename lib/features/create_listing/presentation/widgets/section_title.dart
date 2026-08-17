
import 'package:flutter/material.dart';
import 'package:rentora/core/themes/app_colors.dart';

class SectionTitle extends StatelessWidget {
   const SectionTitle({
    required this.title,
    this.required = false,
  });
  final String title;
  final bool required;

 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF202020),
          ),
        ),
        if (required)
          const Text(
            ' *',
            style: TextStyle(
              color: AppColors.warning,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
