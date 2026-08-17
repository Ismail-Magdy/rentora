


import 'package:flutter/material.dart';
import 'package:rentora/core/themes/app_colors.dart';

class PriceRow extends StatelessWidget {
   const PriceRow({
    required this.label,
    required this.value,
    this.highlighted = false,
  });

  final String label;
  final String value;
  final bool highlighted;

 
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF777F82),
            ),
          ),
        ),

        Text(
          value,
          style: TextStyle(
            fontSize: highlighted ? 18 : 15,
            fontWeight: FontWeight.w800,
            color: highlighted
                ? AppColors.primaryColor
                : const Color(0xFF202020),
          ),
        ),
      ],
    );
  }
}
