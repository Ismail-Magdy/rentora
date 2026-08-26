import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/core/widgets/custom_text_field.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, _) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Material(child: Form(child: child)),
        ),
      ),
    );
  }

  group('CustomTextFormField Tests', () {
    testWidgets('renders hint text and accepts user input', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        buildTestWidget(
          CustomTextFormField(
            controller: controller,
            hintText: 'Enter your email',
            fieldType: FieldType.email,
          ),
        ),
      );

      expect(find.text('Enter your email'), findsOneWidget);
      await tester.enterText(find.byType(TextFormField), 'test@example.com');
      expect(controller.text, 'test@example.com');
    });

    testWidgets('toggles obscure text for password field', (tester) async {
      final controller = TextEditingController(text: 'secret123');
      await tester.pumpWidget(
        buildTestWidget(
          CustomTextFormField(
            controller: controller,
            hintText: 'Password',
            fieldType: FieldType.loginPassword,
          ),
        ),
      );

      // Find toggle icon
      final iconFinder = find.byIcon(Icons.visibility_off);
      expect(iconFinder, findsOneWidget);

      await tester.tap(iconFinder);
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('validates email field on form submit', (tester) async {
      final controller = TextEditingController(text: 'invalid_email');
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(428, 926),
          builder: (context, _) => MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: Form(
                key: formKey,
                child: CustomTextFormField(
                  controller: controller,
                  hintText: 'Email',
                  fieldType: FieldType.email,
                ),
              ),
            ),
          ),
        ),
      );

      formKey.currentState?.validate();
      await tester.pump();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });
  });
}
