import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/add_item/presentation/widgets/header_button.dart';

class InitialPhotoScreen extends StatefulWidget {
  const InitialPhotoScreen({super.key});

  @override
  State<InitialPhotoScreen> createState() => _InitialPhotoScreenState();
}

class _InitialPhotoScreenState extends State<InitialPhotoScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (image == null || !mounted) return;

    final cubit = context.read<AddItemCubit>();
    cubit.setMainPhoto(image);
    context.pushNamed(Routes.dataEntryChoiceScreen, arguments: cubit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                children: [
                  HeaderButton(
                    icon: Icons.close_rounded,
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
                  // Empty placeholder for symmetry
                  SizedBox(width: 42.w),
                ],
              ),
            ),

            // Progress Bar (Step 1)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Photo',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Step 1 of 6',
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
                          flex: 1,
                          child: Container(
                            height: 6.h,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 6.h,
                            color: AppColors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Illustration/Placeholder
                    Container(
                      width: 200.w,
                      height: 200.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 80.sp,
                        color: AppColors.primaryColor.withValues(alpha: 0.5),
                      ),
                    ),
                    verticalSpace(30),
                    Text(
                      'Let\'s start with a photo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27.sp,
                        height: 1.2.h,
                        fontWeight: FontWeight.w800,
                        color: AppColors.black,
                      ),
                    ),
                    verticalSpace(12),
                    Text(
                      'Take a clear photo of the item you want to rent out. This will be the main photo for your listing.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        height: 1.45.h,
                        color: AppColors.grey,
                      ),
                    ),
                    verticalSpace(40),

                    // Action Buttons
                    _buildActionButton(
                      context,
                      icon: Icons.camera_alt_rounded,
                      title: 'Take a Photo',
                      subtitle: 'Use camera',
                      onTap: () => _pickImage(ImageSource.camera),
                    ),
                    verticalSpace(16),
                    _buildActionButton(
                      context,
                      icon: Icons.photo_library_rounded,
                      title: 'Choose from Gallery',
                      subtitle: 'Upload existing photo',
                      onTap: () => _pickImage(ImageSource.gallery),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.grey.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 26.sp),
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13.sp, color: AppColors.grey),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.grey,
              size: 28.sp,
            ),
          ],
        ),
      ),
    );
  }
}
