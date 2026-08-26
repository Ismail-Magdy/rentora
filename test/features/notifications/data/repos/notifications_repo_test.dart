import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/notifications/data/models/notification_model.dart';
import 'package:rentora/features/notifications/data/repos/notifications_repo.dart';

class MockNotificationsRepo extends Mock implements NotificationsRepo {}

void main() {
  late MockNotificationsRepo mockRepo;

  final tNotification = NotificationModel(
    id: 'n1',
    title: 'Booking Approved',
    body: 'Your rental request was accepted.',
    type: 'booking',
    relatedId: 'b1',
    isRead: false,
    createdAt: Timestamp.now(),
  );

  setUp(() {
    mockRepo = MockNotificationsRepo();
  });

  group('NotificationsRepo Contract Tests', () {
    test('getNotificationsStream returns stream of NotificationModel list', () async {
      when(() => mockRepo.getNotificationsStream('user1'))
          .thenAnswer((_) => Stream.value([tNotification]));

      final stream = mockRepo.getNotificationsStream('user1');

      expect(
        stream,
        emitsInOrder([
          [tNotification],
        ]),
      );
      verify(() => mockRepo.getNotificationsStream('user1')).called(1);
    });

    test('markAsRead completes successfully', () async {
      when(() => mockRepo.markAsRead('user1', 'n1'))
          .thenAnswer((_) async {});

      await mockRepo.markAsRead('user1', 'n1');

      verify(() => mockRepo.markAsRead('user1', 'n1')).called(1);
    });
  });
}
