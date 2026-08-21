import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/widgets/custom_text_field.dart';
import 'package:rentora/features/add_item/manager/add_item_state.dart';
import 'package:rentora/features/add_item/presentation/components/add_item_progress_bar.dart';
import 'package:rentora/features/add_item/presentation/widgets/price_field.dart';
import 'package:rentora/features/add_item/presentation/widgets/section_title.dart';

class AddItemDetailsScreen extends StatefulWidget {
  const AddItemDetailsScreen({super.key});

  @override
  State<AddItemDetailsScreen> createState() => _AddItemDetailsScreenState();
}

class _AddItemDetailsScreenState extends State<AddItemDetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController depositController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  String? selectedCondition;

  final List<String> conditions = ['Like New', 'Excellent', 'Good', 'Fair'];

  final List<String> availableFeatures = [
    'Wireless',
    'Portable',
    'HD 4K',
    'Bluetooth',
    'Waterproof',
    'Rechargeable',
    'Lightweight',
    'Heavy Duty',
  ];

  @override
  void initState() {
    super.initState();
    // Populate from Cubit if in edit mode
    final state = context.read<AddItemCubit>().state;
    nameController.text = state.title;
    descriptionController.text = state.description;
    priceController.text = state.dailyPrice > 0
        ? state.dailyPrice.toString()
        : '';
    depositController.text = state.securityDeposit > 0
        ? state.securityDeposit.toString()
        : '';
    ratingController.text = state.rating > 0
        ? state.rating.toString()
        : '';
    selectedCondition = state.condition.isNotEmpty ? state.condition : null;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    depositController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  void onNext() {
    final title = nameController.text.trim();
    final description = descriptionController.text.trim();
    final price = double.tryParse(priceController.text) ?? 0;
    final deposit = double.tryParse(depositController.text) ?? 0;
    final rating = double.tryParse(ratingController.text) ?? -1.0;
    final cubit = context.read<AddItemCubit>();

    if (title.isEmpty ||
        description.isEmpty ||
        price <= 0 ||
        deposit < 0 ||
        rating < 0.0 ||
        rating > 5.0 ||
        selectedCondition == null ||
        cubit.state.keyFeatures.length < 3) {
      showFeedbackDialog(
        context,
        icon: Icons.warning_amber_rounded,
        color: AppColors.warning,
        title: 'Incomplete Information',
        message:
            'Please complete all required fields. Rating must be between 0.0 and 5.0, and at least 3 features must be selected.',
      );
      return;
    }

    cubit.updateTitle(title);
    cubit.updateDescription(description);
    cubit.updateDailyPrice(price);
    cubit.updateSecurityDeposit(deposit);
    cubit.updateCondition(selectedCondition!);
    cubit.updateRating(rating);

    Navigator.pushNamed(
      context,
      Routes.addPhotosScreen,
      arguments: context.read<AddItemCubit>(),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header (unchanged)
            CustomAppBar(text: "Add New Listing"),

            AddItemProgressBar(
              title: "Item details",
              stepNumber: "Step 4 of 7",
            ),

            // Content (unchanged, but we may want to use Cubit state for initial values)
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tell us about your item',
                      style: TextStyle(
                        fontSize: 27.sp,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        color: AppColors.black,
                      ),
                    ),

                    verticalSpace(8),
                    Text(
                      'Add some details to help renters understand what you are offering.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.45.h,
                        color: AppColors.grey,
                      ),
                    ),

                    verticalSpace(22),
                    const SectionTitle(title: 'Item name', required: true),
                    verticalSpace(8),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: 'e.g. Canon EOS R50 Camera',
                      icon: Icons.title_outlined,
                    ),
                    verticalSpace(18),
                    const SectionTitle(title: 'Description', required: true),
                    verticalSpace(8),
                    CustomTextFormField(
                      controller: descriptionController,
                      hintText:
                          'Describe the item, its features and condition...',
                      maxLines: 4,
                    ),
                    verticalSpace(18),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SectionTitle(
                                title: 'Daily price',
                                required: true,
                              ),
                              verticalSpace(8),
                              PriceField(
                                controller: priceController,
                                hintText: '0',
                              ),
                            ],
                          ),
                        ),
                        horizontalSpace(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SectionTitle(
                                title: 'Security deposit',
                                required: true,
                              ),
                              verticalSpace(8),
                              PriceField(
                                controller: depositController,
                                hintText: '0',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(18),
                    const SectionTitle(title: 'Item condition & Rating', required: true),
                    verticalSpace(8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.grey.withValues(alpha: 0.3),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedCondition,
                                isExpanded: true,
                                hint: const Text(
                                  'Condition',
                                  style: TextStyle(color: AppColors.grey),
                                ),
                                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                items: conditions.map((condition) {
                                  return DropdownMenuItem<String>(
                                    value: condition,
                                    child: Text(condition),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCondition = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace(12),
                        Expanded(
                          child: CustomTextFormField(
                            controller: ratingController,
                            hintText: 'Rating (0-5)',
                            icon: Icons.star_border,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(22),
                    const SectionTitle(
                      title: 'Key Features (Select at least 3)',
                      required: true,
                    ),
                    verticalSpace(12),
                    BlocBuilder<AddItemCubit, AddItemState>(
                      builder: (context, state) {
                        return Wrap(
                          spacing: 8.w,
                          runSpacing: 10.h,
                          children: availableFeatures.map((feature) {
                            final isSelected = state.keyFeatures.contains(
                              feature,
                            );
                            return FilterChip(
                              label: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                              ),
                              selected: isSelected,
                              showCheckmark: false,
                              onSelected: (_) {
                                context.read<AddItemCubit>().toggleKeyFeature(
                                  feature,
                                );
                              },
                              selectedColor: AppColors.primaryColor,
                              backgroundColor: AppColors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 8.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.grey.withValues(alpha: 0.3),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    verticalSpace(22),
                    Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                          horizontalSpace(10),
                          Expanded(
                            child: Text(
                              'The security deposit is held as protection against damage or loss and may be returned after the rental.',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 12.sp,
                                height: 1.4.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: CustomButton(text: "Next", onPressed: onNext),
            ),
          ],
        ),
      ),
    );
  }
}
// 403