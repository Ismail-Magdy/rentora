import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/search/presentation/widgets/filter_section.dart';

import '../../../../helpers/test_helper.dart';

void main() {
  group('FilterSection Widget Tests', () {
    testWidgets('renders title and child widget', (tester) async {
      await tester.pumpApp(
        const FilterSection(title: 'Location', child: Text('Child content')),
      );

      expect(find.text('Location'), findsOneWidget);
      expect(find.text('Child content'), findsOneWidget);
      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpApp(
        const FilterSection(
          title: 'Category',
          icon: Icons.category_outlined,
          child: Text('Category options'),
        ),
      );

      expect(find.text('Category'), findsOneWidget);
      expect(find.byIcon(Icons.category_outlined), findsOneWidget);
      expect(find.text('Category options'), findsOneWidget);
    });
  });
}
