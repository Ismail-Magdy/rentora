import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';

class TeamMember {
  final String name;
  final String role;
  final String imagePath;

  TeamMember({required this.name, required this.role, required this.imagePath});
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final teamMembers = [
      TeamMember(
        name: 'Ismail Magdy',
        role: 'Team Leader',
        imagePath: 'assets/images/profiles/ismail.jpeg',
      ),
      TeamMember(
        name: 'Ghada Essam',
        role: 'Member',
        imagePath: 'assets/images/profiles/ghada.jpeg',
      ),
      TeamMember(
        name: 'Kerols Gamal',
        role: 'Member',
        imagePath: 'assets/images/profiles/kero.jpeg',
      ),
      TeamMember(
        name: 'Wessam Zakaria',
        role: 'Member',
        imagePath: 'assets/images/profiles/wessam.jpeg',
      ),
      TeamMember(
        name: 'Essam Ibrahim',
        role: 'Member',
        imagePath: 'assets/images/profiles/essam.jpeg',
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(text: 'About Rentora'),
      body: SingleChildScrollView(
        padding: .symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            // App Logo
            Hero(
              tag: 'app_logo',
              child: Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? AppColors.darkCard : AppColors.lightGrey,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withValues(alpha: 0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.handshake_rounded,
                  size: 60,
                  color: AppColors.primaryColor,
                ), // Fallback Icon
              ),
            ),
            verticalSpace(24),
            Text(
              'Rentora',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: .bold,
                color: isDark ? AppColors.darkTextPrimary : AppColors.black,
              ),
            ),
            verticalSpace(16),
            Text(
              'Rentora is a premier peer-to-peer rental marketplace. We empower individuals to monetize their unused belongings and help others find exactly what they need for a fraction of the cost. Our mission is to build a sustainable, community-driven economy',
              textAlign: .center,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.6,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.darkGrey,
              ),
            ),
            verticalSpace(36),
            Align(
              alignment: .centerLeft,
              child: Text(
                'Meet Our Team',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: .bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                ),
              ),
            ),
            verticalSpace(20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 20.h,
                childAspectRatio: 0.85,
              ),
              itemCount: teamMembers.length,
              itemBuilder: (context, index) {
                final member = teamMembers[index];
                return GestureDetector(
                  onTap: () => _showTeamMemberPopup(context, member),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkBorder
                            : Colors.transparent,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? AppColors.darkShadow
                              : AppColors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Hero(
                          tag: member.name,
                          child: CircleAvatar(
                            radius: 40.r,
                            backgroundColor: AppColors.primaryColor.withValues(
                              alpha: 0.1,
                            ),
                            backgroundImage: AssetImage(member.imagePath),
                            onBackgroundImageError: (_, _) {},
                          ),
                        ),
                        verticalSpace(12),
                        Text(
                          member.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.black,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        verticalSpace(4),
                        Text(
                          member.role,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            verticalSpace(40),
          ],
        ),
      ),
    );
  }

  void _showTeamMemberPopup(BuildContext context, TeamMember member) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5 * animation.value,
            sigmaY: 5 * animation.value,
          ),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: FadeTransition(
              opacity: animation,
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    Hero(
                      tag: member.name,
                      child: Container(
                        width: 200.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          shape: .circle,
                          border: .all(
                            color: AppColors.primaryColor,
                            width: 4.w,
                          ),
                          image: DecorationImage(
                            image: AssetImage(member.imagePath),
                            fit: .cover,
                          ),
                        ),
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: Image.asset(
                              member.imagePath,
                              fit: .cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.person,
                                    size: 100,
                                    color: AppColors.primaryColor,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(24),
                    Container(
                      padding: .symmetric(horizontal: 24.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : AppColors.white,
                        borderRadius: .circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            member.name,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: .bold,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          verticalSpace(8),
                          Container(
                            padding: .symmetric(
                              horizontal: 16.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: .circular(12.r),
                            ),
                            child: Text(
                              member.role,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.primaryColor,
                                fontWeight: .w600,
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
          ),
        );
      },
    );
  }
}
