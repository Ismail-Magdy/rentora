import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/add_item/data/models/category_model.dart';
import 'package:rentora/features/add_item/presentation/components/add_item_action_button.dart';
import 'package:rentora/features/add_item/presentation/components/add_item_progress_bar.dart';
import 'package:rentora/features/add_item/presentation/widgets/category_card.dart';
import 'package:rentora/features/add_item/presentation/widgets/section_header.dart';

Widget createTestableWidget(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(428, 926),
    builder: (context, _) => MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  group('AddItem Widgets Tests', () {
    testWidgets('SectionHeader renders title and triggers edit callback', (
      tester,
    ) async {
      bool editTapped = false;
      await tester.pumpWidget(
        createTestableWidget(
          SectionHeader(
            title: 'General Details',
            onEdit: () => editTapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('General Details'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);

      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      expect(editTapped, true);
    });

    testWidgets(
      'AddItemActionButton renders title, subtitle, icon and handles tap',
      (tester) async {
        bool tapped = false;
        await tester.pumpWidget(
          createTestableWidget(
            AddItemActionButton(
              icon: Icons.camera_alt,
              title: 'Take Photo',
              subtitle: 'Use your camera',
              onTap: () => tapped = true,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Take Photo'), findsOneWidget);
        expect(find.text('Use your camera'), findsOneWidget);
        expect(find.byIcon(Icons.camera_alt), findsOneWidget);

        await tester.tap(find.text('Take Photo'));
        await tester.pumpAndSettle();
        expect(tapped, true);
      },
    );

    testWidgets(
      'CategoryCard renders category data and responds to selection and tap',
      (tester) async {
        bool tapped = false;
        const category = CategoryModel(
          id: 'cat_1',
          title: 'Electronics',
          subtitle: 'Cameras & Drones',
          icon: Icons.tv,
          color: Colors.blue,
        );

        await tester.pumpWidget(
          createTestableWidget(
            CategoryCard(
              category: category,
              isSelected: true,
              onTap: () => tapped = true,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Electronics'), findsOneWidget);
        expect(find.text('Cameras & Drones'), findsOneWidget);
        expect(find.byIcon(Icons.tv), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);

        await tester.tap(find.byType(CategoryCard));
        await tester.pumpAndSettle();
        expect(tapped, true);
      },
    );

    testWidgets('AddItemProgressBar displays title and step number', (
      tester,
    ) async {
      await tester.pumpWidget(
        createTestableWidget(
          const AddItemProgressBar(
            title: 'Upload Photos',
            stepNumber: 'Step 1 of 4',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Upload Photos'), findsOneWidget);
      expect(find.text('Step 1 of 4'), findsOneWidget);
    });
  });
}
