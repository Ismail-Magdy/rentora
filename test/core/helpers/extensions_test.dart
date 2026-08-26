import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/core/helpers/extensions.dart';

void main() {
  group('StringExtension.capitalizeFirst', () {
    test('capitalizes the first character only', () {
      expect('rentora'.capitalizeFirst(), equals('Rentora'));
      expect('rENTORA'.capitalizeFirst(), equals('RENTORA'));
    });

    test('returns empty string unchanged', () {
      expect(''.capitalizeFirst(), isEmpty);
    });
  });

  group('BuildContext extensions', () {
    testWidgets('exposes theme data and dark mode state', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(capturedContext.theme.brightness, Brightness.light);
      expect(capturedContext.colorScheme.brightness, Brightness.light);
      expect(capturedContext.textTheme, isNotNull);
      expect(capturedContext.isDarkMode, isFalse);
    });

    testWidgets('pushNamed navigates to a registered route', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/next': (_) => const Scaffold(body: Text('Next Screen')),
          },
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: TextButton(
                  onPressed: () => context.pushNamed('/next'),
                  child: const Text('Go'),
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();

      expect(find.text('Next Screen'), findsOneWidget);
    });
  });
}
