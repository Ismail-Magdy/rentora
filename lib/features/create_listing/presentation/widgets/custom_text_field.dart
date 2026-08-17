import 'package:flutter/material.dart';
import 'package:rentora/core/themes/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final IconData? icon;
    
  final TextInputType? keyboardType;
  final String? prefixText;


  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.icon,
      this.keyboardType,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
         keyboardType: keyboardType,
      textInputAction:
          maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
          prefixText: prefixText,
        prefixIcon: icon == null
            ? null
            : Icon(
                icon,
                color: const Color(0xFF899094),
              ),
        hintStyle: const TextStyle(
          color: Color(0xFF9BA1A4),
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFDDE2E3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFDDE2E3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
