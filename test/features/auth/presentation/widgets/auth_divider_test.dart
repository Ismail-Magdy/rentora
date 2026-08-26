import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/auth/presentation/widgets/auth_divider.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('AuthDivider renders localized text and dividers', (
    tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, _) => const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: AuthDivider()),
        ),
      ),
    );

    expect(find.text('Or'), findsOneWidget);
    expect(find.byType(Divider), findsNWidgets(2));
  });
}
