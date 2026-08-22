import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/setting/presentation/widgets/logout_dialog.dart';
import 'package:rentora/features/setting/presentation/widgets/settings_section.dart';
import 'package:rentora/features/setting/presentation/widgets/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  Future<void> _logout() async {
    await getIt<FirebaseAuthService>().signOut();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/welcomeAuthScreen',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        children: [
          SettingsSection(
            title: 'Account',
            children: [
              SettingsTile(
                icon: Icons.person_outline,
                title: 'View Profile',
                onTap: () => Navigator.pushNamed(context, '/profileScreen'),
              ),
              SettingsTile(
                icon: Icons.verified_user_outlined,
                title: 'Account Verification',
                onTap: () =>
                    Navigator.pushNamed(context, '/verificationScreen'),
              ),
            ],
          ),

          SettingsSection(
            title: 'Preferences',
            children: [
              SettingsTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                ),
              ),
              SettingsTile(
                icon: Icons.language,
                title: 'Language & Region',
                subtitle: 'Arabic',
                onTap: () {},
              ),
            ],
          ),

          SettingsSection(
            title: 'Support',
            children: [
              SettingsTile(
                icon: Icons.help_outline,
                title: 'Help Center',
                onTap: () => Navigator.pushNamed(context, '/helpCenterScreen'),
              ),
              SettingsTile(
                icon: Icons.info_outline,
                title: 'About Rentora',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style:
                    OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide.none,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 1.5,
                    ).copyWith(
                      shadowColor: WidgetStateProperty.all(AppColors.darkGrey),
                    ),
                onPressed: () {
                  showLogoutDialog(context, onConfirm: _logout);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_rounded, color: Colors.red, size: 22.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
