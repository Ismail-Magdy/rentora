
import 'package:flutter/material.dart';
import 'package:rentora/core/themes/app_colors.dart';

class ReviewCard extends StatelessWidget {
    const ReviewCard({
    required this.title,
    required this.icon,
    required this.child,
    this.onEdit,
  });
  final String title;
  final IconData icon;
  final Widget child;
  final VoidCallback? onEdit;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE3E7E8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor
                      .withOpacity(.08),
                  borderRadius:
                      BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color:
                      AppColors.primaryColor,
                  size: 20,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              if (onEdit != null)
                InkWell(
                  onTap: onEdit,
                  borderRadius:
                      BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color:
                          AppColors.primaryColor,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 17),

          child,
        ],
      ),
    );
  }
}

