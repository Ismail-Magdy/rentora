import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/search/presentation/widgets/price_range_fields.dart';

import '../../../../helpers/test_helper.dart';

void main() {
  setUpAll(() {
    initTestEnvironment();
  });

  group('PriceRangeFields Widget Tests', () {
    testWidgets('renders min and max price text fields with hints', (
      tester,
    ) async {
      final minController = TextEditingController();
      final maxController = TextEditingController();

      await tester.pumpApp(
        PriceRangeFields(
          minController: minController,
          maxController: maxController,
        ),
      );

      expect(find.text('Min Price'), findsOneWidget);
      expect(find.text('Max Price'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
    });

    testWidgets('triggers onMinChanged and onMaxChanged callbacks', (
      tester,
    ) async {
      final minController = TextEditingController();
      final maxController = TextEditingController();
      String minVal = '';
      String maxVal = '';

      await tester.pumpApp(
        PriceRangeFields(
          minController: minController,
          maxController: maxController,
          onMinChanged: (v) => minVal = v,
          onMaxChanged: (v) => maxVal = v,
        ),
      );

      final textFields = find.byType(TextField);
      await tester.enterText(textFields.first, '20');
      await tester.pump();
      expect(minVal, equals('20'));

      await tester.enterText(textFields.last, '150');
      await tester.pump();
      expect(maxVal, equals('150'));
    });
  });
}
