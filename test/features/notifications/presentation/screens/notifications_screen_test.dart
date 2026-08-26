import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/notifications/data/models/notification_model.dart';
import 'package:rentora/features/notifications/manager/notifications_cubit.dart';
import 'package:rentora/features/notifications/manager/notifications_state.dart';
import 'package:rentora/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:rentora/features/notifications/presentation/widgets/notification_card.dart';
import '../../../../helpers/test_helper.dart';

class MockNotificationsCubit extends MockCubit<NotificationsState>
    implements NotificationsCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setUpAll(() {
    initTestEnvironment();
    registerFallbackValue(MaterialPageRoute(builder: (_) => const SizedBox()));
  });

  late MockNotificationsCubit mockCubit;

  final tUnreadNotif = NotificationModel(
    id: 'notif_1',
    title: 'Unread Notification',
    body: 'You have a pending rental request.',
    type: 'booking',
    relatedId: 'booking_1',
    isRead: false,
    createdAt: Timestamp.now(),
  );

  final tReadNotif = NotificationModel(
    id: 'notif_2',
    title: 'Read Notification',
    body: 'Your profile has been approved.',
    type: 'system',
    relatedId: 'sys_1',
    isRead: true,
    createdAt: Timestamp.now(),
  );

  setUp(() {
    mockCubit = MockNotificationsCubit();
  });

  group('NotificationsScreen Widget Tests', () {
    testWidgets('renders skeleton list when loading', (tester) async {
      when(() => mockCubit.state).thenReturn(NotificationsLoading());

      await tester.pumpApp(
        BlocProvider<NotificationsCubit>.value(
          value: mockCubit,
          child: const NotificationsScreen(),
        ),
      );
      await tester.pump();

      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Unread'), findsOneWidget);
      expect(find.text('Read'), findsOneWidget);
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('renders error text on NotificationsError', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(const NotificationsError('Something went wrong'));

      await tester.pumpApp(
        BlocProvider<NotificationsCubit>.value(
          value: mockCubit,
          child: const NotificationsScreen(),
        ),
      );
      await tester.pump();

      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('renders unread and read notifications in tabs', (tester) async {
      when(() => mockCubit.state).thenReturn(
        NotificationsLoaded(
          unreadNotifications: [tUnreadNotif],
          readNotifications: [tReadNotif],
        ),
      );

      await tester.pumpApp(
        BlocProvider<NotificationsCubit>.value(
          value: mockCubit,
          child: const NotificationsScreen(),
        ),
      );
      await tester.pump();

      expect(find.text('Unread Notification'), findsOneWidget);

      // Switch to Read tab
      await tester.tap(find.text('Read'));
      await tester.pumpAndSettle();

      expect(find.text('Read Notification'), findsOneWidget);
    });

    testWidgets('renders empty state messages when notification lists are empty', (tester) async {
      when(() => mockCubit.state).thenReturn(
        const NotificationsLoaded(
          unreadNotifications: [],
          readNotifications: [],
        ),
      );

      await tester.pumpApp(
        BlocProvider<NotificationsCubit>.value(
          value: mockCubit,
          child: const NotificationsScreen(),
        ),
      );
      await tester.pump();

      expect(find.text('No unread notifications'), findsOneWidget);

      await tester.tap(find.text('Read'));
      await tester.pumpAndSettle();

      expect(find.text('No read notifications'), findsOneWidget);
    });

    testWidgets('back button pops the screen', (tester) async {
      when(() => mockCubit.state).thenReturn(
        const NotificationsLoaded(
          unreadNotifications: [],
          readNotifications: [],
        ),
      );

      final observer = MockNavigatorObserver();

      await tester.pumpApp(
        BlocProvider<NotificationsCubit>.value(
          value: mockCubit,
          child: const NotificationsScreen(),
        ),
        navigatorObserver: observer,
      );
      await tester.pump();

      await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
      await tester.pumpAndSettle();

      verify(() => observer.didPop(any(), any())).called(1);
    });
  });
}
