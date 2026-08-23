import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/routing/app_router.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/settings_controller.dart';
import 'package:rentora/core/themes/app_theme.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Rentora extends StatelessWidget {
  const Rentora({super.key, required this.appRouter, this.settingsController});

  final AppRouter appRouter;
  final SettingsController? settingsController;

  @override
  Widget build(BuildContext context) {
    final controller = settingsController ?? SettingsController();
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: controller.themeMode,
            locale: controller.locale,
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            onGenerateRoute: appRouter.generateRoute,
            initialRoute: Routes.welcomeAuthScreen,
          ),
        ),
      ),
    );
  }
}
