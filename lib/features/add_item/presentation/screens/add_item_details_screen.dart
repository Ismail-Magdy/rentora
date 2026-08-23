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
import 'package:rentora/l10n/generated/app_localizations.dart';

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
    ratingController.text = state.rating > 0 ? state.rating.toString() : '';
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
    final l10n = AppLocalizations.of(context)!;
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
        title: l10n.incompleteInformation,
        message: l10n.completeRequiredFields,
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
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header (unchanged)
            CustomAppBar(text: l10n.addNewListing),

            AddItemProgressBar(
              title: l10n.itemDetailsLabel,
              stepNumber: l10n.stepOf("4", "7"),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.tellAboutItem,
                      style: TextStyle(
                        fontSize: 27.sp,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                      ),
                    ),

                    verticalSpace(8),
                    Text(
                      l10n.itemDetailsInstruction,
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.45.h,
                        color: AppColors.grey,
                      ),
                    ),

                    verticalSpace(22),
                    SectionTitle(title: l10n.itemName, required: true),
                    verticalSpace(8),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: l10n.itemNameExample,
                      icon: Icons.title_outlined,
                    ),
                    verticalSpace(18),
                    SectionTitle(title: l10n.description, required: true),
                    verticalSpace(8),
                    CustomTextFormField(
                      controller: descriptionController,
                      hintText: l10n.descriptionHint,
                      maxLines: 4,
                    ),
                    verticalSpace(18),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionTitle(
                                title: l10n.dailyPrice,
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
                              SectionTitle(
                                title: l10n.securityDeposit,
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
                    SectionTitle(
                      title: l10n.itemConditionRating,
                      required: true,
                    ),
                    verticalSpace(8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkSurface : AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark
                                    ? AppColors.darkBorder
                                    : AppColors.grey.withValues(alpha: 0.3),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: isDark ? AppColors.darkSurface : AppColors.white,
                                value: selectedCondition,
                                isExpanded: true,
                                hint: Text(
                                  l10n.condition,
                                  style: const TextStyle(color: AppColors.grey),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                ),
                                items: conditions.map((condition) {
                                  return DropdownMenuItem<String>(
                                    value: condition,
                                    child: Text(
                                      condition,
                                      style: TextStyle(
                                        color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                                      ),
                                    ),
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
                            hintText: l10n.ratingRange,
                            icon: Icons.star_border,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(22),
                    SectionTitle(title: l10n.keyFeaturesSelect, required: true),
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
                              l10n.securityDepositInfo,
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
              child: CustomButton(text: l10n.next, onPressed: onNext),
            ),
          ],
        ),
      ),
    );
  }
}

// 403
