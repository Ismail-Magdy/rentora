import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/profile/manager/cubit/profile_cubit.dart';
import 'package:rentora/features/profile/manager/cubit/profile_state.dart';
import 'package:rentora/features/profile/presentation/screens/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline,
            color: Colors.red,
            title: 'Error',
            message: state.message,
          );
        } else if (state is ProfileUpdated) {
          showFeedbackDialog(
            context,
            icon: Icons.check_circle,
            color: Colors.green,
            title: 'Success',
            message: 'Profile updated successfully',
          );
        } else if (state is ProfileUpdateError) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline,
            color: Colors.red,
            title: 'Error',
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        final user = context.read<ProfileCubit>().currentUser;

        if (user == null) {
          return Scaffold(
            backgroundColor: const Color(0xFFF1F3F4),
            appBar: AppBar(
              title: const Text('My Profile'),
              centerTitle: true,
              backgroundColor: const Color(0xFFF1F3F4),
              elevation: 0,
            ),
            body: state is ProfileError
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state.message),
                        SizedBox(height: 12.h),
                        FilledButton(
                          onPressed: () =>
                              context.read<ProfileCubit>().loadProfile(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          );
        }

        final hasAvatar = user.avatarUrl != null && user.avatarUrl!.isNotEmpty;

        return Scaffold(
          backgroundColor: const Color(0xFFF1F3F4),
          appBar: AppBar(
            title: const Text('My Profile'),
            centerTitle: true,
            backgroundColor: const Color(0xFFF1F3F4),
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.edit_outlined, color: AppColors.primaryColor),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<ProfileCubit>(),
                      child: EditProfileScreen(user: user),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              Column(
                children: [
                  hasAvatar
                      ? CachedNetworkImage(
                          imageUrl: user.avatarUrl!,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 88.r,
                            height: 88.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => CircleAvatar(
                            radius: 44.r,
                            backgroundColor: AppColors.primaryColor.withValues(
                              alpha: 0.15,
                            ),
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 44.r,
                            backgroundColor: AppColors.primaryColor.withValues(
                              alpha: 0.15,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 40.w,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 44.r,
                          backgroundColor: AppColors.primaryColor.withValues(
                            alpha: 0.15,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 40.w,
                            color: AppColors.primaryColor,
                          ),
                        ),
                  SizedBox(height: 12.h),
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _verificationChip(user.verificationStatus),
                ],
              ),
              SizedBox(height: 24.h),
              _infoCard(
                icon: Icons.phone_android,
                title: 'Phone Number',
                value: user.phoneNumber,
              ),
              SizedBox(height: 12.h),
              _infoCard(
                icon: Icons.info_outline,
                title: 'Bio',
                value: user.bio.isEmpty ? 'No bio added yet.' : user.bio,
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.interests_outlined,
                          color: AppColors.primaryColor,
                          size: 20.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Interests',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    if (user.interests.isEmpty)
                      Text(
                        'No interests selected yet.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      )
                    else
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: user.interests
                            .map(
                              (interest) => Chip(
                                label: Text(
                                  interest,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: AppColors.primaryColor,
                                side: BorderSide(color: AppColors.primaryColor),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 2.h,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _verificationChip(String status) {
    Color color;
    switch (status) {
      case 'verified':
        color = Colors.green;
        break;
      case 'pending':
        color = Colors.orange;
        break;
      case 'rejected':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
            child: Icon(icon, color: AppColors.primaryColor, size: 18.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
