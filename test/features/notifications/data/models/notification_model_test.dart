import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/notifications/data/models/notification_model.dart';

void main() {
  group('NotificationModel', () {
    test('round trips notification data', () {
      final timestamp = Timestamp.fromDate(DateTime(2026, 1, 1));
      final model = NotificationModel(
        id: 'n1',
        title: 'Booking',
        body: 'Updated',
        type: 'booking',
        relatedId: 'b1',
        isRead: false,
        createdAt: timestamp,
      );
      final result = NotificationModel.fromJson(model.toJson());
      expect(result.id, 'n1');
      expect(result.title, 'Booking');
      expect(result.body, 'Updated');
      expect(result.type, 'booking');
      expect(result.relatedId, 'b1');
      expect(result.isRead, isFalse);
      expect(result.createdAt, timestamp);
    });

    test('uses safe defaults', () {
      final result = NotificationModel.fromJson({});
      expect(result.id, '');
      expect(result.isRead, isFalse);
      expect(result.createdAt, isNull);
    });
  });
}
