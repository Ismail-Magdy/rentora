


import 'package:flutter/material.dart';
import 'package:rentora/features/create_listing/presentation/widgets/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = category.color;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? categoryColor
                : const Color(0xFFE9ECEE),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                isSelected ? .08 : .035,
              ),
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Selection Check
            Positioned(
              top: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? categoryColor
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? categoryColor
                        : const Color(0xFFD9DDDF),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 17,
                      )
                    : null,
              ),
            ),

            // Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: categoryColor.withOpacity(.12),
                    ),
                    child: Icon(
                      category.icon,
                      size: 34,
                      color: categoryColor,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    category.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w700,
                      color: isSelected
                          ? categoryColor
                          : const Color(0xFF171717),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    category.subtitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      height: 1.25,
                      color: Color(0xFF777E82),
                    ),
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
