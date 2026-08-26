import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/notifications/data/models/notification_model.dart';
import 'package:rentora/features/notifications/data/repos/notifications_repo.dart';
import 'package:rentora/features/notifications/manager/notifications_cubit.dart';
import 'package:rentora/features/notifications/manager/notifications_state.dart';
import '../../../helpers/firebase_test_helper.dart';

class MockNotificationsRepo extends Mock implements NotificationsRepo {}

void main() {
  setUpAll(() async {
    await setupMockFirebase();
  });

  late MockNotificationsRepo mockRepo;
  NotificationsCubit? cubit;

  setUp(() {
    mockRepo = MockNotificationsRepo();
  });

  tearDown(() {
    cubit?.close();
    cubit = null;
  });

  group('NotificationsCubit Tests', () {
    test('emits NotificationsError when user is null', () {
      final c = NotificationsCubit(mockRepo);
      cubit = c;
      expect(c.state, isA<NotificationsError>());
      expect(
        (c.state as NotificationsError).message,
        'User not authenticated',
      );
    });

    test('markAsRead returns gracefully when user is null', () async {
      final c = NotificationsCubit(mockRepo);
      cubit = c;
      await c.markAsRead('notif_1');
      expect(c.state, isA<NotificationsError>());
    });

    test('NotificationsLoaded state stores read and unread lists accurately', () {
      final unread = [
        NotificationModel(
          id: '1',
          title: 'Unread',
          body: 'Msg',
          type: 'chat',
          relatedId: 'c1',
          isRead: false,
          createdAt: Timestamp.now(),
        ),
      ];
      final read = [
        NotificationModel(
          id: '2',
          title: 'Read',
          body: 'Msg',
          type: 'booking',
          relatedId: 'b1',
          isRead: true,
          createdAt: Timestamp.now(),
        ),
      ];

      final state = NotificationsLoaded(
        unreadNotifications: unread,
        readNotifications: read,
      );

      expect(state.unreadNotifications.length, 1);
      expect(state.readNotifications.length, 1);
      expect(state.unreadNotifications.first.id, '1');
      expect(state.readNotifications.first.id, '2');
    });

    test('NotificationsError stores message accurately', () {
      const state = NotificationsError('Failed to fetch');
      expect(state.message, 'Failed to fetch');
    });
  });
}
