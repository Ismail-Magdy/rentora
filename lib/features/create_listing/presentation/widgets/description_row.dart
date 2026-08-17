
import 'package:flutter/material.dart';

class DescriptionRow extends StatelessWidget {
    const DescriptionRow({
    required this.description,
  });

  final String description;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF777F82),
          ),
        ),

        const SizedBox(height: 7),

        Text(
          description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            height: 1.45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
