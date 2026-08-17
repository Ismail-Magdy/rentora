
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
    const InfoRow({
    required this.label,
    required this.value,
    this.valueBold = false,
  });

  final String label;
  final String value;
  final bool valueBold;


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
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

        const SizedBox(width: 15),

        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: valueBold
                  ? FontWeight.w800
                  : FontWeight.w600,
              color: const Color(0xFF202020),
            ),
          ),
        ),
      ],
    );
  }
}

