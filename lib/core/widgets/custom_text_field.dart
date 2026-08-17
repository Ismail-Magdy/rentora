import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

enum FieldType { text, email, phoneNumber, password }

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final IconData? prefixIcon;
  final FieldType fieldType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.fieldType = FieldType.text,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  TextInputType get _keyboardType {
    switch (widget.fieldType) {
      case FieldType.email:
        return TextInputType.emailAddress;
      case FieldType.phoneNumber:
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }

  String? _validate(String? value) {
    if (widget.validator != null) return widget.validator!(value);

    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    switch (widget.fieldType) {
      case FieldType.email:
        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
          return 'Please enter a valid email address';
        }
        break;
      case FieldType.phoneNumber:
        if (!RegExp(r'^\+?[0-9\s]{8,15}$').hasMatch(value.trim())) {
          return 'Please enter a valid phone number';
        }
        break;
      case FieldType.password:
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        break;
      default:
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final bool isPassword = widget.fieldType == FieldType.password;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // السر هنا: الليبل بقى Text عادي فوق الـ TextFormField
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF3B4A5A),
            ),
          ),
          SizedBox(height: 6.h),
        ],
        TextFormField(
          controller: widget.controller,
          keyboardType: _keyboardType,
          obscureText: isPassword ? _obscureText : false,
          validator: _validate,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade400),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: Colors.grey.shade500,
                    size: 20.w,
                  )
                : null,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey.shade500,
                      size: 20.w,
                    ),
                    onPressed: () {
                      setState(() => _obscureText = !_obscureText);
                    },
                  )
                : null,
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
