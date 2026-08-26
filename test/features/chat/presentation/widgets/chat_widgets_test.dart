import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/chat/presentation/widgets/chat_empty_state.dart';

Widget createChatWidgetTestable(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(428, 926),
    builder: (context, _) => MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  group('Chat Widgets Tests', () {
    testWidgets('ChatEmptyState renders title, message, and icon', (
      tester,
    ) async {
      await tester.pumpWidget(
        createChatWidgetTestable(
          const ChatEmptyState(
            title: 'No Messages Yet',
            message: 'Start a conversation with the item owner.',
            icon: Icons.chat_bubble_outline,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No Messages Yet'), findsOneWidget);
      expect(
        find.text('Start a conversation with the item owner.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
    });
  });
}
