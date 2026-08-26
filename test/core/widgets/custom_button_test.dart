import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/core/widgets/custom_button.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, _) => MaterialApp(home: Scaffold(body: child)),
    );
  }

  group('CustomButton Tests', () {
    testWidgets('renders button text and triggers callback', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        buildTestWidget(
          CustomButton(text: 'Click Me', onPressed: () => tapped = true),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
      await tester.tap(find.text('Click Me'));
      expect(tapped, isTrue);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        buildTestWidget(
          CustomButton(
            text: 'Loading Button',
            isLoading: true,
            onPressed: () => tapped = true,
          ),
        ),
      );

      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      expect(find.text('Loading Button'), findsNothing);
      await tester.tap(find.byType(CupertinoActivityIndicator));
      expect(tapped, isFalse);
    });

    testWidgets('renders icon and prefixIcon correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          CustomButton(
            text: 'Icon Button',
            icon: Icons.check,
            onPressed: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('Icon Button'), findsOneWidget);
    });
  });
}
