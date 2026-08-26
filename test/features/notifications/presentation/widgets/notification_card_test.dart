import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/features/notifications/data/models/notification_model.dart';
import 'package:rentora/features/notifications/manager/notifications_cubit.dart';
import 'package:rentora/features/notifications/manager/notifications_state.dart';
import 'package:rentora/features/notifications/presentation/widgets/notification_card.dart';
import '../../../../helpers/test_helper.dart';

class MockNotificationsCubit extends MockCubit<NotificationsState>
    implements NotificationsCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setUpAll(() {
    initTestEnvironment();
  });

  group('NotificationCard Widget Tests', () {
    testWidgets('renders unread notification content and time', (tester) async {
      final cubit = MockNotificationsCubit();
      when(() => cubit.state).thenReturn(NotificationsInitial());
      final notification = NotificationModel(
        id: 'n1',
        title: 'Booking update',
        body: 'Your request changed',
        type: 'booking',
        relatedId: 'b1',
        isRead: false,
        createdAt: Timestamp.fromDate(
          DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      );
      await tester.pumpApp(
        BlocProvider<NotificationsCubit>.value(
          value: cubit,
          child: NotificationCard(notification: notification),
        ),
      );
      expect(find.text('Booking update'), findsOneWidget);
      expect(find.text('Your request changed'), findsOneWidget);
      expect(find.text('5m ago'), findsOneWidget);
    });

    testWidgets('renders read notification with chat icon and triggers chat navigation on tap', (tester) async {
      final cubit = MockNotificationsCubit();
      when(() => cubit.state).thenReturn(NotificationsInitial());
      when(() => cubit.markAsRead(any())).thenAnswer((_) async {});

      final notification = NotificationModel(
        id: 'n2',
        title: 'New Message',
        body: 'Hey there!',
        type: 'chat',
        relatedId: 'chat_123',
        isRead: true,
        createdAt: Timestamp.fromDate(
          DateTime.now().subtract(const Duration(hours: 2)),
        ),
      );

      String? pushedRoute;
      dynamic pushedArgs;

      await tester.pumpApp(
        BlocProvider<NotificationsCubit>.value(
          value: cubit,
          child: NotificationCard(notification: notification),
        ),
        onGenerateRoute: (settings) {
          pushedRoute = settings.name;
          pushedArgs = settings.arguments;
          return MaterialPageRoute(builder: (_) => const Scaffold(body: Text('Target Screen')));
        },
      );

      expect(find.text('New Message'), findsOneWidget);
      expect(find.text('Hey there!'), findsOneWidget);
      expect(find.text('2h ago'), findsOneWidget);

      await tester.tap(find.byType(NotificationCard));
      await tester.pumpAndSettle();

      verifyNever(() => cubit.markAsRead(any()));
      expect(pushedRoute, Routes.chatScreen);
      expect(pushedArgs, 'chat_123');
    });

    testWidgets('marks unread notification as read and navigates to incomingRentalRequest on tap', (tester) async {
      final cubit = MockNotificationsCubit();
      when(() => cubit.state).thenReturn(NotificationsInitial());
      when(() => cubit.markAsRead('n3')).thenAnswer((_) async {});

      final notification = NotificationModel(
        id: 'n3',
        title: 'New Rental Request',
        body: 'Someone wants to rent your item',
        type: 'booking',
        relatedId: 'req_1',
        isRead: false,
        createdAt: Timestamp.fromDate(
          DateTime.now().subtract(const Duration(days: 3)),
        ),
      );

      String? pushedRoute;

      await tester.pumpApp(
        BlocProvider<NotificationsCubit>.value(
          value: cubit,
          child: NotificationCard(notification: notification),
        ),
        onGenerateRoute: (settings) {
          pushedRoute = settings.name;
          return MaterialPageRoute(builder: (_) => const Scaffold(body: Text('Target Screen')));
        },
      );

      expect(find.text('3d ago'), findsOneWidget);

      await tester.tap(find.byType(NotificationCard));
      await tester.pumpAndSettle();

      verify(() => cubit.markAsRead('n3')).called(1);
      expect(pushedRoute, Routes.incomingRentalRequestScreen);
    });

    testWidgets('renders different time strings correctly (days, weeks, months, years, just now)', (tester) async {
      final cubit = MockNotificationsCubit();
      when(() => cubit.state).thenReturn(NotificationsInitial());

      final notificationJustNow = NotificationModel(
        id: 'n4',
        title: 'Immediate',
        body: 'Just now notification',
        type: 'other',
        relatedId: 'other_1',
        isRead: true,
        createdAt: Timestamp.fromDate(DateTime.now()),
      );

      await tester.pumpApp(
        BlocProvider<NotificationsCubit>.value(
          value: cubit,
          child: NotificationCard(notification: notificationJustNow),
        ),
      );

      expect(find.text('just now'), findsOneWidget);
    });
  });
}
