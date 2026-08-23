import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: .circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightGrey,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppColors.darkShadow
                : AppColors.black.withValues(alpha: 0.04),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          horizontalSpace(14),
          GestureDetector(
            onTap: () => widget.onSubmitted?.call(_controller.text),
            child: Icon(
              Icons.search_rounded,
              size: 24.sp,
              color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
            ),
          ),
          horizontalSpace(10),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (val) {
                setState(() {});
                widget.onChanged?.call(val);
              },
              onSubmitted: widget.onSubmitted,
              textInputAction: TextInputAction.search,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? AppColors.darkTextPrimary : AppColors.black,
              ),
              decoration: InputDecoration(
                hintText: l10n.searchItems,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: isDark ? AppColors.darkTextMuted : AppColors.darkGrey,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
                setState(() {});
                widget.onChanged?.call('');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Icon(
                  Icons.close_rounded,
                  size: 18.sp,
                  color: isDark ? AppColors.darkTextMuted : AppColors.grey,
                ),
              ),
            ),
          Container(
            width: 1.w,
            height: 28.h,
            color: isDark ? AppColors.darkDivider : AppColors.lightGrey,
          ),
          IconButton(
            onPressed: widget.onFilterPressed,
            icon: Icon(
              Icons.tune_rounded,
              size: 23.sp,
              color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
            ),
            tooltip: l10n.filters,
          ),
          horizontalSpace(4),
        ],
      ),
    );
  }
}
