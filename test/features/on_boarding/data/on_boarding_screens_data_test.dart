import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/on_boarding/data/on_boarding_screens_data.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('getOnboardingData returns 4 items with localized texts', (
    tester,
  ) async {
    late AppLocalizations l10n;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            l10n = AppLocalizations.of(context)!;
            return Container();
          },
        ),
      ),
    );

    final list = getOnboardingData(l10n);
    expect(list.length, 4);
    expect(list[0].title, l10n.onboardingTitle1);
    expect(list[0].description, l10n.onboardingDesc1);
    expect(list[0].image, contains('pic1.png'));
    expect(list[3].image, contains('pic4.png'));
  });
}
