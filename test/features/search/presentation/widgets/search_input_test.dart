import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/search/presentation/widgets/search_input.dart';

import '../../../../helpers/test_helper.dart';

void main() {
  setUpAll(() {
    initTestEnvironment();
  });

  group('SearchInput Widget Tests', () {
    testWidgets('renders hint text and search icon', (tester) async {
      await tester.pumpApp(const SearchInput());

      expect(find.text('Search items'), findsOneWidget);
      expect(find.byIcon(Icons.search_rounded), findsOneWidget);
      expect(find.byIcon(Icons.tune_rounded), findsOneWidget);
    });

    testWidgets('initialValue is set in the text field', (tester) async {
      await tester.pumpApp(const SearchInput(initialValue: 'PlayStation'));

      expect(find.text('PlayStation'), findsOneWidget);
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);
    });

    testWidgets('triggers onChanged when typing', (tester) async {
      String typedValue = '';
      await tester.pumpApp(SearchInput(onChanged: (val) => typedValue = val));

      await tester.enterText(find.byType(TextField), 'Drone');
      await tester.pump();

      expect(typedValue, equals('Drone'));
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);
    });

    testWidgets(
      'clears text and triggers onChanged with empty string when close icon is tapped',
      (tester) async {
        String changedValue = 'initial';
        await tester.pumpApp(
          SearchInput(
            initialValue: 'Scooter',
            onChanged: (val) => changedValue = val,
          ),
        );

        expect(find.byIcon(Icons.close_rounded), findsOneWidget);
        await tester.tap(find.byIcon(Icons.close_rounded));
        await tester.pump();

        expect(changedValue, equals(''));
        expect(find.byIcon(Icons.close_rounded), findsNothing);
      },
    );

    testWidgets(
      'triggers onSubmitted when search icon or keyboard done is pressed',
      (tester) async {
        String submittedValue = '';
        await tester.pumpApp(
          SearchInput(
            initialValue: 'Camera',
            onSubmitted: (val) => submittedValue = val,
          ),
        );

        await tester.tap(find.byIcon(Icons.search_rounded));
        await tester.pump();

        expect(submittedValue, equals('Camera'));
      },
    );

    testWidgets('triggers onFilterPressed when filter icon is tapped', (
      tester,
    ) async {
      bool filterPressed = false;
      await tester.pumpApp(
        SearchInput(onFilterPressed: () => filterPressed = true),
      );

      await tester.tap(find.byIcon(Icons.tune_rounded));
      await tester.pump();

      expect(filterPressed, isTrue);
    });
  });
}
