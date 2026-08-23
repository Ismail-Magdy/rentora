import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/shared_prefrences_helper.dart';
import 'package:rentora/core/routing/routes.dart';
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
      appBar: AppBar(
        title: Text(
          localizations.settingsTitle,
          style: TextStyle(
            color: controller?.isDarkMode == true
                ? AppColors.darkTextPrimary
                : AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        children: [
          SettingsSection(
            title: localizations.accountSection,
            children: [
              SettingsTile(
                icon: Icons.person_outline,
                title: localizations.viewProfile,
                onTap: () => Navigator.pushNamed(context, '/profileScreen'),
              ),
              SettingsTile(
                icon: Icons.verified_user_outlined,
                title: localizations.accountVerification,
                onTap: () =>
                    Navigator.pushNamed(context, '/verificationScreen'),
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
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
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
                      : Colors.white,
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
                  onChanged: (value) => controller?.setThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light,
                  ),
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
                onTap: () => Navigator.pushNamed(context, '/helpCenterScreen'),
              ),
              SettingsTile(
                icon: Icons.info_outline,
                title: localizations.aboutRentora,
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
                style: OutlinedButton.styleFrom(
                  backgroundColor: controller?.isDarkMode == true
                      ? AppColors.darkSurface
                      : Colors.white,
                  side: BorderSide.none,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 1.5,
                ).copyWith(
                  shadowColor: WidgetStateProperty.all(
                    controller?.isDarkMode == true
                        ? AppColors.darkShadow
                        : AppColors.darkGrey,
                  ),
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
                      localizations.logout,
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
