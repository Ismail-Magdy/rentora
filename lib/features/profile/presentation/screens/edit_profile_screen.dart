import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/core/widgets/custom_text_field.dart';
import 'package:rentora/features/auth/data/models/user_model.dart';
import 'package:rentora/features/profile/manager/cubit/profile_cubit.dart';
import 'package:rentora/features/profile/manager/cubit/profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController nameController = TextEditingController(
    text: widget.user.name,
  );
  late final TextEditingController emailController = TextEditingController(
    text: widget.user.email,
  );
  late final TextEditingController phoneController = TextEditingController(
    text: widget.user.phoneNumber,
  );
  late final TextEditingController bioController = TextEditingController(
    text: widget.user.bio,
  );
  final formKey = GlobalKey<FormState>();

  File? _avatarFile;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile == null) return;

    setState(() {
      _avatarFile = File(pickedFile.path);
    });
  }

  void _save() {
    if (!formKey.currentState!.validate()) return;

    context.read<ProfileCubit>().saveProfile(
      name: nameController.text,
      phoneNumber: phoneController.text,
      bio: bioController.text,
      avatarFile: _avatarFile,
    );
  }

  String get _accountSubtitle {
    switch (widget.user.verificationStatus) {
      case 'verified':
        return 'Verified Owner';
      case 'pending':
        return 'Verification Pending';
      case 'rejected':
        return 'Verification Rejected';
      default:
        return 'Unverified Owner';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          showFeedbackDialog(
            context,
            icon: Icons.check_circle_outline,
            color: Colors.green,
            title: 'Success!',
            message: 'Your profile has been updated successfully.',
            onFinish: () {
              if (Navigator.of(context).canPop()) {
                Navigator.pop(context);
              }
            },
          );
        } else if (state is ProfileUpdateError) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline,
            color: Colors.red,
            title: 'Oops!',
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        final isUpdating = state is ProfileUpdating;

        return Scaffold(
          backgroundColor: const Color(0xFFF1F3F4),
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFFF1F3F4),
            elevation: 0,
            actions: [
              isUpdating
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SizedBox(
                        width: 18.w,
                        height: 18.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: _save,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 8.h),
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 44.r,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: _avatarFile != null
                                  ? FileImage(_avatarFile!)
                                  : (widget.user.avatarUrl != null &&
                                            widget.user.avatarUrl!.isNotEmpty
                                        ? NetworkImage(widget.user.avatarUrl!)
                                        : null),
                              child:
                                  _avatarFile == null &&
                                      (widget.user.avatarUrl == null ||
                                          widget.user.avatarUrl!.isEmpty)
                                  ? Icon(
                                      Icons.image_outlined,
                                      size: 32.w,
                                      color: Colors.grey.shade400,
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 14.r,
                                backgroundColor: AppColors.primaryColor,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    size: 14.w,
                                    color: Colors.white,
                                  ),
                                  onPressed: _pickAvatar,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        GestureDetector(
                          onTap: _pickAvatar,
                          child: Text(
                            'Change Profile Picture',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'JPG, PNG, GIF. Max 5 MB.',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _sectionCard(
                    title: 'Personal Information',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Full Name'),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          controller: nameController,
                          hintText: 'Your name',
                          prefixIcon: Icons.person_outline,
                        ),
                        SizedBox(height: 14.h),
                        _label('Email Address'),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: widget.user.email,
                          prefixIcon: Icons.mail_outline,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Email cannot be changed',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        _label('Phone Number'),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          controller: phoneController,
                          hintText: '+966 5X XXX XXXX',
                          prefixIcon: Icons.phone_android,
                          fieldType: .phoneNumber,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _sectionCard(
                    title: 'Bio',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: bioController,
                          hintText: 'Write something about yourself...',
                          fieldType: .normal,
                          maxLines: 5,
                          maxLength: 300,
                          onChanged: (_) => setState(() {}),
                        ),
                        SizedBox(height: 4.h),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            '${bioController.text.length}/300 Characters',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.r,
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(
                            Icons.verified_outlined,
                            color: Colors.white,
                            size: 18.w,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account Type',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _accountSubtitle,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primaryColor,
                          size: 20.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 14.h),
          child,
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF3B4A5A),
      ),
    );
  }
}
