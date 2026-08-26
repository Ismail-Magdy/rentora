import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/search/presentation/widgets/search_categories.dart';

import '../../../../helpers/test_helper.dart';

void main() {
  setUpAll(() {
    initTestEnvironment();
  });

  group('SearchCategories Widget Tests', () {
    final categories = ['Cameras', 'Gaming', 'Sports'];

    testWidgets('renders All chip and category chips', (tester) async {
      await tester.pumpApp(
        SearchCategories(
          categories: categories,
          selectedCategory: null,
          onCategorySelected: (_) {},
        ),
      );

      expect(find.text('All'), findsOneWidget);
      expect(find.text('Cameras'), findsOneWidget);
      expect(find.text('Gaming'), findsOneWidget);
      expect(find.text('Sports'), findsOneWidget);
    });

    testWidgets('triggers onCategorySelected with null when All is tapped', (
      tester,
    ) async {
      String? selected = 'Cameras';
      await tester.pumpApp(
        SearchCategories(
          categories: categories,
          selectedCategory: 'Cameras',
          onCategorySelected: (cat) => selected = cat,
        ),
      );

      await tester.tap(find.text('All'));
      await tester.pump();

      expect(selected, isNull);
    });

    testWidgets(
      'triggers onCategorySelected with category name when category chip is tapped',
      (tester) async {
        String? selected;
        await tester.pumpApp(
          SearchCategories(
            categories: categories,
            selectedCategory: null,
            onCategorySelected: (cat) => selected = cat,
          ),
        );

        await tester.tap(find.text('Gaming'));
        await tester.pump();

        expect(selected, equals('Gaming'));
      },
    );
  });
}
