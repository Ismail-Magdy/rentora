import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/item_details/presentation/widgets/item_features_section.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

Widget createItemDetailsWidgetTestable(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(428, 926),
    builder: (context, _) => MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('ItemDetails Widgets Tests', () {
    testWidgets('ItemFeaturesSection displays key features with check icons', (
      tester,
    ) async {
      await tester.pumpWidget(
        createItemDetailsWidgetTestable(
          const ItemFeaturesSection(
            features: ['4K Video', 'Waterproof', 'Tripod Included'],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Key Features'), findsOneWidget);
      expect(find.text('4K Video'), findsOneWidget);
      expect(find.text('Waterproof'), findsOneWidget);
      expect(find.text('Tripod Included'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsNWidgets(3));
    });
  });
}
