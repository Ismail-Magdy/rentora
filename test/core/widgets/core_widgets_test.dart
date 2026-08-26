import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/core/widgets/error_screen.dart';
import 'package:rentora/core/widgets/unknown_route_screen.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

void main() {
  Widget buildWrapper(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, _) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    );
  }

  group('Core Widgets Tests', () {
    testWidgets('CustomFeedbackDialog displays title, message, and icon', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildWrapper(
          const CustomFeedbackDialog(
            icon: Icons.check_circle,
            color: Colors.green,
            title: 'Success Operation',
            message: 'Your item was saved successfully',
          ),
        ),
      );

      expect(find.text('Success Operation'), findsOneWidget);
      expect(find.text('Your item was saved successfully'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('ErrorScreen renders error messages', (tester) async {
      await tester.pumpWidget(buildWrapper(const ErrorScreen()));

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Please try again later'), findsOneWidget);
    });

    testWidgets('UnknownRouteScreen renders not found messages', (
      tester,
    ) async {
      await tester.pumpWidget(buildWrapper(const UnknownRouteScreen()));

      expect(find.text("Looks like you're off the map"), findsOneWidget);
      expect(
        find.text(
          'The page you are looking for does not exist or has been moved',
        ),
        findsOneWidget,
      );
      expect(find.text('Go Back'), findsOneWidget);
    });
  });
}
