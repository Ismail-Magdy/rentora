import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/shared_prefrences_helper.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/widgets/custom_app_bar_without_leading.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';
import 'package:rentora/rentora.dart';
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
    await SharedPrefHelper.removeData('hasFinishedSetup');
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.welcomeAuthScreen,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = context.findAncestorWidgetOfExactType<Rentora>();
    final controller = settings?.settingsController;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBarWithNoLeading(text: localizations.settingsTitle),
      body: ListView(
        padding: .symmetric(vertical: 8.h),
        children: [
          SettingsSection(
            title: localizations.accountSection,
            children: [
              SettingsTile(
                icon: Icons.person_outline,
                title: localizations.viewProfile,
                onTap: () => context.pushNamed(Routes.profileScreen),
              ),
              SettingsTile(
                icon: Icons.verified_user_outlined,
                title: localizations.accountVerification,
                onTap: () async {
                  final userId = FirebaseAuth.instance.currentUser?.uid;
                  if (userId != null) {
                    final userDoc = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .get();
                    if (userDoc.exists) {
                      final verificationStatus =
                          userDoc.data()?['verificationStatus'] ?? 'unverified';
                      if (verificationStatus == 'verified' ||
                          userDoc.data()?['isVerified'] == true) {
                        if (context.mounted) {
                          context.pushNamed(Routes.verifiedSuccessScreen);
                        }
                      } else {
                        if (context.mounted) {
                          context.pushNamed(Routes.verificationIntroScreen);
                        }
                      }
                    }
                  }
                },
              ),
            ],
          ),

          SettingsSection(
            title: localizations.preferencesSection,
            children: [
              SettingsTile(
                icon: Icons.notifications_outlined,
                title: localizations.notifications,
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) =>
                      setState(() => _notificationsEnabled = value),
                ),
              ),
              SettingsTile(
                icon: Icons.language,
                title: localizations.languageLabel,
                subtitle: controller?.locale.languageCode == 'ar'
                    ? localizations.arabic
                    : localizations.english,
                trailing: DropdownButton<Locale>(
                  dropdownColor: controller?.isDarkMode == true
                      ? AppColors.darkSurface
                      : AppColors.white,
                  value: controller?.locale ?? const Locale('en'),
                  underline: const SizedBox.shrink(),
                  items: [
                    DropdownMenuItem(
                      value: const Locale('en'),
                      child: Text(localizations.english),
                    ),
                    DropdownMenuItem(
                      value: const Locale('ar'),
                      child: Text(localizations.arabic),
                    ),
                  ],
                  onChanged: (locale) {
                    if (locale != null) controller?.setLocale(locale);
                  },
                ),
              ),
              SettingsTile(
                icon: Icons.brightness_6_outlined,
                title: localizations.themeLabel,
                subtitle: controller?.isDarkMode == true
                    ? localizations.darkTheme
                    : localizations.lightTheme,
                trailing: Switch(
                  value: controller?.isDarkMode ?? false,
                  onChanged: (value) =>
                      controller?.setThemeMode(value ? .dark : .light),
                ),
              ),
            ],
          ),

          SettingsSection(
            title: localizations.supportSection,
            children: [
              SettingsTile(
                icon: Icons.help_outline,
                title: localizations.helpCenter,
                onTap: () => context.pushNamed(Routes.helpCenterScreen),
              ),
              SettingsTile(
                icon: Icons.info_outline,
                title: localizations.aboutRentora,
                onTap: () {
                  context.pushNamed(Routes.aboutUsScreen);
                },
              ),
            ],
          ),
          verticalSpace(16),

          Padding(
            padding: .symmetric(horizontal: 16.w),
            child: CustomButton(
              height: 52.h,
              prefixIcon: Icon(
                Icons.logout_rounded,
                color: Colors.red,
                size: 22.sp,
              ),
              borderColor: AppColors.grey.withValues(alpha: 0.5),
              color: AppColors.white,
              textColor: AppColors.error,
              text: localizations.logout,
              onPressed: () => showLogoutDialog(context, onConfirm: _logout),
            ),
          ),
        ],
      ),
    );
  }
}
// 197