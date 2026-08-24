import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:rentora/features/setup_profile/data/models/category_model.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('localizes known categories and keeps unknown name', (
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
            return const SizedBox();
          },
        ),
      ),
    );
    expect(
      CategoryModel(
        id: 'gaming',
        name: 'x',
        iconPath: 'x',
      ).getLocalizedName(l10n),
      l10n.categoryGaming,
    );
    expect(
      CategoryModel(
        id: 'unknown',
        name: 'Custom',
        iconPath: 'x',
      ).getLocalizedName(l10n),
      'Custom',
    );
  });

  test('provides the predefined category list', () {
    expect(CategoryModel.categories, isNotEmpty);
    expect(CategoryModel.categories.map((c) => c.id), contains('cameras'));
  });
}
