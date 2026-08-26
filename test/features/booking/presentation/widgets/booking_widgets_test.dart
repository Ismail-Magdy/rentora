import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/booking/presentation/widgets/custom_empty_state.dart';
import 'package:rentora/features/booking/presentation/widgets/info_notice_card.dart';

Widget createBookingWidgetTestable(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(428, 926),
    builder: (context, _) => MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  group('Booking Widgets Tests', () {
    testWidgets('InfoNoticeCard displays message and icon', (tester) async {
      await tester.pumpWidget(
        createBookingWidgetTestable(
          const InfoNoticeCard(
            message: 'Please pick up the item on time',
            icon: Icons.info_outline,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Please pick up the item on time'), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('CustomEmptyState displays title, message, and icon', (
      tester,
    ) async {
      await tester.pumpWidget(
        createBookingWidgetTestable(
          const CustomEmptyState(
            icon: Icons.calendar_today,
            title: 'No Bookings Yet',
            message: 'You have not made any booking requests yet.',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No Bookings Yet'), findsOneWidget);
      expect(
        find.text('You have not made any booking requests yet.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });
  });
}
