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

  /// Called whenever the text changes.
  final void Function(String)? onChanged;

  /// Keyboard type override (optional).
  final TextInputType? keyboardType;

  /// Maximum number of characters allowed.
  final int? maxLength;

  /// Input formatters (useful for phone numbers, digits, etc).
  final List<TextInputFormatter>? inputFormatters;

  /// Controls auto validation behavior.
  final AutovalidateMode autovalidateMode;

  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.fieldType = FieldType.text,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    this.autovalidateMode = .onUserInteraction,
    this.textInputAction,
    this.onFieldSubmitted,
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
    return TextFormField(
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,

      /// Use custom validator if provided, otherwise fallback to default validator.
      validator: widget.validator ?? _defaultValidator,

      /// Triggered whenever the user types.
      onChanged: widget.onChanged,

      /// Keyboard type configuration.
      keyboardType: _getKeyboardType(),

      /// Optional max length constraint.
      maxLength: widget.maxLength,

      /// Input formatters support.
      inputFormatters: widget.inputFormatters,

      /// Hide text only for password fields.
      obscureText: obscureText,

      /// Controls when validation runs.
      autovalidateMode: widget.autovalidateMode,

      /// Text style inside the field.
      style: TextStyle(color: AppColors.primaryColor, fontSize: 14.sp),

      ///
      decoration: InputDecoration(
        hintText: widget.hintText,

        hintStyle: const TextStyle(color: Color(0x7F4A628A)),

        /// Optional prefix icon.
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: Colors.grey)
            : null,

        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.08),

        border: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: .none,
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ],
    );
  }
}
