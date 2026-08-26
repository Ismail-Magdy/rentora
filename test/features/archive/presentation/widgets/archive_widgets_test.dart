import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/archive/presentation/widgets/archive_tab_bar.dart';
import 'package:rentora/features/archive/presentation/widgets/owner_earnings_summary_card.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

Widget createArchiveTestWidget(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(800, 1200),
    minTextAdapt: true,
    builder: (context, _) => MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: SingleChildScrollView(child: child)),
    ),
  );
}

void main() {
  group('Archive Widgets Tests', () {
    testWidgets('ArchiveTabBar renders tabs and handles tab controller', (
      tester,
    ) async {
      final tabController = TabController(length: 2, vsync: const TestVSync());

      await tester.pumpWidget(
        createArchiveTestWidget(ArchiveTabBar(tabController: tabController)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(Tab), findsNWidgets(2));
    });

    testWidgets(
      'OwnerEarningsSummaryCard renders earnings, total bookings, and active rentals',
      (tester) async {
        await tester.pumpWidget(
          createArchiveTestWidget(
            const OwnerEarningsSummaryCard(
              totalEarnings: 1500.0,
              totalRentals: 12,
              activeRentals: 3,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.textContaining('1500'), findsOneWidget);
        expect(find.text('12'), findsOneWidget);
        expect(find.text('3'), findsOneWidget);
        expect(find.byIcon(Icons.trending_up_rounded), findsOneWidget);
        expect(find.byIcon(Icons.assignment_outlined), findsOneWidget);
        expect(find.byIcon(Icons.timelapse_rounded), findsOneWidget);
      },
    );
  });
}
