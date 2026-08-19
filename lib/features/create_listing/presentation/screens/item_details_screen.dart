import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/create_listing/manager/cubit/listing_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/widgets/custom_text_field.dart';
// C:\Users\DELL\Desktop\ieee\rentora\lib\core\widgets\custom_text_field.dart
import 'package:rentora/features/create_listing/presentation/widgets/header_button.dart';
import 'package:rentora/features/create_listing/presentation/widgets/price_field.dart';
import 'package:rentora/features/create_listing/presentation/widgets/section_title.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({super.key});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController depositController = TextEditingController();

  String? selectedCondition;

  final List<String> conditions = [
    'Like New',
    'Excellent',
    'Good',
    'Fair',
  ];

  @override
  void initState() {
    super.initState();
    // Populate from Cubit if in edit mode
  final state = context.read<ListingCubit>().state;
    nameController.text = state.title;
    descriptionController.text = state.description;
    priceController.text = state.dailyPrice > 0 ? state.dailyPrice.toString() : '';
    depositController.text = state.securityDeposit > 0 ? state.securityDeposit.toString() : '';
    selectedCondition = state.condition.isNotEmpty ? state.condition : null;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    depositController.dispose();
    super.dispose();
  }
void onNext() {
  final title = nameController.text.trim();
  final description = descriptionController.text.trim();
  final price = double.tryParse(priceController.text) ?? 0;
  final deposit = double.tryParse(depositController.text) ?? 0;

  if (title.isEmpty ||
      description.isEmpty ||
      price <= 0 ||
      deposit < 0 ||
      selectedCondition == null) {
  showFeedbackDialog(
  context,
  icon: Icons.warning_amber_rounded,
  color: AppColors.warning,
  title: 'Incomplete Information',
  message: 'Please complete all required fields.',
);
    return;
  }

  final cubit = context.read<ListingCubit>();

  cubit.updateTitle(title);
  cubit.updateDescription(description);
  cubit.updateDailyPrice(price);
  cubit.updateSecurityDeposit(deposit);
  cubit.updateCondition(selectedCondition!);

Navigator.pushNamed(
  context,
  Routes.addPhotosScreen,
  arguments: context.read<ListingCubit>(),
);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header (unchanged)
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                children: [
                  HeaderButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                   Expanded(
                    child: Center(
                      child: Text(
                        'Add New Listing',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  HeaderButton(
                    icon: Icons.close,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Progress (unchanged)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Item details',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Step 2 of 4',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 6.h,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 6.h,
                            color: AppColors.grey.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Content (unchanged, but we may want to use Cubit state for initial values)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
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
                    const SectionTitle(
                      title: 'Item name',
                      required: true,
                    ),
                    verticalSpace(8),
                    CustomTextFormField (
                      controller: nameController,
                      hintText: 'e.g. Canon EOS R50 Camera',
                      icon: Icons.title_outlined,
                    ),
                    verticalSpace(18),
                    const SectionTitle(
                      title: 'Description',
                      required: true,
                    ),
                    verticalSpace(8),
                    CustomTextFormField (
                      controller: descriptionController,
                      hintText: 'Describe the item, its features and condition...',
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
                        const SizedBox(width: 12),
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
                    const SectionTitle(
                      title: 'Item condition',
                      required: true,
                    ),
                    verticalSpace(8),
                    Container(
                      padding:  EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCondition,
                          isExpanded: true,
                          hint: const Text(
                            'Select condition',
                            style: TextStyle(
                              color: AppColors.grey,
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
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
                    verticalSpace(18),
                    Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(.06),
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
                          horizontalSpace( 10),
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
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 56.h,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child:  Text(
                          'Back',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(10),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: onNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            horizontalSpace(8),
                            Icon(
                              Icons.arrow_forward_rounded,
                            ),
                          ],
                        ),
                      ),
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