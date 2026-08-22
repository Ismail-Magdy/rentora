import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/search/manager/search_cubit.dart';
import 'package:rentora/features/search/manager/search_state.dart';
import 'package:rentora/features/search/presentation/widgets/filter_section.dart';
import 'package:rentora/features/search/presentation/widgets/price_range_fields.dart';
import 'package:rentora/features/search/presentation/widgets/search_categories.dart';

class SearchFilters extends StatefulWidget {
  const SearchFilters({super.key});

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  late final TextEditingController _minPriceController;
  late final TextEditingController _maxPriceController;
  late final TextEditingController _locationController;

  static const List<String> _categories = [
    'Cameras',
    'Gaming',
    'Laptops',
    'Sports',
    'Tools',
    'Travel',
  ];

  static const List<String> _conditions = ['New', 'Like New', 'Good', 'Fair'];

  @override
  void initState() {
    super.initState();

    final filter = context.read<SearchCubit>().state.filter;

    _minPriceController = TextEditingController(
      text: filter.minPrice?.toString() ?? '',
    );

    _maxPriceController = TextEditingController(
      text: filter.maxPrice?.toString() ?? '',
    );

    _locationController = TextEditingController(text: filter.location ?? '');
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterSection(
                title: 'Category',
                icon: Icons.category_outlined,
                child: SearchCategories(
                  categories: _categories,
                  selectedCategory: state.filter.category,
                  onCategorySelected: cubit.updateCategory,
                ),
              ),

              verticalSpace(26),

              FilterSection(
                title: 'Price Range',
                icon: Icons.payments_outlined,
                child: PriceRangeFields(
                  minController: _minPriceController,
                  maxController: _maxPriceController,
                  onMinChanged: (value) {
                    cubit.updateMinPrice(double.tryParse(value));
                  },
                  onMaxChanged: (value) {
                    cubit.updateMaxPrice(double.tryParse(value));
                  },
                ),
              ),

              verticalSpace(26),

              FilterSection(
                title: 'Condition',
                icon: Icons.auto_awesome_outlined,
                child: _ConditionSelector(
                  conditions: _conditions,
                  selectedCondition: state.filter.condition,
                  onSelected: cubit.updateCondition,
                ),
              ),

              verticalSpace(26),

              FilterSection(
                title: 'Location',
                icon: Icons.location_on_outlined,
                child: _LocationField(
                  controller: _locationController,
                  onChanged: cubit.updateLocation,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ConditionSelector extends StatelessWidget {
  final List<String> conditions;
  final String? selectedCondition;
  final ValueChanged<String?> onSelected;

  const _ConditionSelector({
    required this.conditions,
    required this.selectedCondition,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        _ConditionChip(
          label: 'All',
          selected: selectedCondition == null,
          onTap: () => onSelected(null),
        ),
        ...conditions.map(
          (condition) => _ConditionChip(
            label: condition,
            selected: condition == selectedCondition,
            onTap: () => onSelected(condition),
          ),
        ),
      ],
    );
  }
}

class _ConditionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ConditionChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: selected ? AppColors.primaryColor : AppColors.lightGrey,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.white : AppColors.darkGrey,
          ),
        ),
      ),
    );
  }
}

class _LocationField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _LocationField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        onChanged(value.trim().isEmpty ? null.toString() : value);
      },
      textInputAction: TextInputAction.done,
      style: TextStyle(fontSize: 14.sp, color: AppColors.black),
      decoration: InputDecoration(
        hintText: 'Enter location',
        hintStyle: TextStyle(fontSize: 13.sp, color: AppColors.darkGrey),
        prefixIcon: Icon(
          Icons.location_on_outlined,
          color: AppColors.primaryColor,
          size: 22.sp,
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
        ),
      ),
    );
  }
}
