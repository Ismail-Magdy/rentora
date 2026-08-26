import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/profile/manager/profile_cubit.dart';
import 'package:rentora/features/profile/manager/profile_state.dart';
import 'package:rentora/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline,
            color: AppColors.error,
            title: l10n.error,
            message: state.message,
          );
        } else if (state is ProfileUpdated) {
          showFeedbackDialog(
            context,
            icon: Icons.check_circle,
            color: AppColors.primaryColor,
            title: l10n.success,
            message: l10n.profileUpdated,
          );
        } else if (state is ProfileUpdateError) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline,
            color: AppColors.error,
            title: l10n.error,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        final user = context.read<ProfileCubit>().currentUser;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        if (user == null) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: CustomAppBar(text: l10n.myProfile),
            body: state is ProfileError
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state.message),
                        verticalSpace(12),
                        FilledButton(
                          onPressed: () =>
                              context.read<ProfileCubit>().loadProfile(),
                          child: Text(l10n.retry),
                        ),
                      ],
                    ),
                  )
                : const Center(child: CupertinoActivityIndicator()),
          );
        }

        final hasAvatar = user.avatarUrl != null && user.avatarUrl!.isNotEmpty;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: CustomAppBar(
            text: l10n.myProfile,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: isDark
                      ? AppColors.secondaryColor
                      : AppColors.primaryColor,
                ),
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
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
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
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _verificationChip(user.verificationStatus, l10n),
                ],
              ),
              SizedBox(height: 24.h),
              _infoCard(
                context,
                icon: Icons.phone_android,
                title: l10n.phoneNumber,
                value: user.phoneNumber,
              ),
              SizedBox(height: 12.h),
              _infoCard(
                context,
                icon: Icons.info_outline,
                title: l10n.bio,
                value: user.bio.isEmpty ? l10n.noBio : user.bio,
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : Colors.transparent,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.interests_outlined,
                          color: isDark
                              ? AppColors.secondaryColor
                              : AppColors.primaryColor,
                          size: 20.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          l10n.interests,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    if (user.interests.isEmpty)
                      Text(
                        l10n.noInterestsSelected,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark
                              ? AppColors.darkTextMuted
                              : Colors.grey.shade600,
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

  Widget _verificationChip(String status, AppLocalizations l10n) {
    Color color;
    String text;
    switch (status) {
      case 'verified':
        color = Colors.green;
        text = l10n.verified;
        break;
      case 'pending':
        color = Colors.orange;
        text = l10n.underReview;
        break;
      case 'rejected':
        color = Colors.red;
        text = l10n.verificationRejected;
        break;
      default:
        color = Colors.grey;
        text = l10n.unverified;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _infoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : Colors.transparent,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor:
                (isDark ? AppColors.secondaryColor : AppColors.primaryColor)
                    .withValues(alpha: 0.15),
            child: Icon(
              icon,
              color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
              size: 18.w,
            ),
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
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.black,
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
// 381