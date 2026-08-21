import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/add_item/presentation/components/add_item_action_button.dart';
import 'package:rentora/features/add_item/presentation/components/add_item_progress_bar.dart';

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
            CustomAppBar(text: "Add New Listing"),
            // Progress Bar (Step 1)
            AddItemProgressBar(title: "Add Photo", stepNumber: "Step 1 of 7"),
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
                    AddItemActionButton(
                      icon: Icons.camera_alt_rounded,
                      title: 'Take a Photo',
                      subtitle: 'Use camera',
                      onTap: () => _pickImage(ImageSource.camera),
                    ),
                    verticalSpace(16),
                    AddItemActionButton(
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
}
