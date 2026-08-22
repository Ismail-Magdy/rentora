import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class SearchInput extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onFilterPressed;

  const SearchInput({
    super.key,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.onFilterPressed,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(16.r),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          horizontalSpace(14),
          Icon(
            Icons.search_rounded,
            size: 24.sp,
            color: AppColors.primaryColor,
          ),
          horizontalSpace(10),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              textInputAction: TextInputAction.search,
              style: TextStyle(fontSize: 14.sp, color: AppColors.black),
              decoration: InputDecoration(
                hintText: 'Search items',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.darkGrey,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Container(width: 1.w, height: 28.h, color: AppColors.lightGrey),
          IconButton(
            onPressed: widget.onFilterPressed,
            icon: Icon(
              Icons.tune_rounded,
              size: 23.sp,
              color: AppColors.primaryColor,
            ),
            tooltip: 'Filters',
          ),
          horizontalSpace(4),
        ],
      ),
    );
  }
}
