import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class InfoNoticeCard extends StatelessWidget {
  final IconData icon;
  final String message;
  final double iconSize;

  const InfoNoticeCard({
    super.key,
    this.icon = Icons.info_outline,
    required this.message,
    this.iconSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: iconSize),
          horizontalSpace(8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
