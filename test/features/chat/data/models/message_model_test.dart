import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/chat/data/models/message_model.dart';

void main() {
  group('MessageModel', () {
    test('round trips fields with timestamp and image', () {
      final timestamp = Timestamp.fromDate(DateTime(2026, 1, 1));
      final model = MessageModel(
        messageId: 'm1',
        senderId: 'u1',
        text: 'Hello',
        imageUrl: 'img',
        timestamp: timestamp,
      );
      final result = MessageModel.fromJson(model.toJson());
      expect(result.messageId, 'm1');
      expect(result.senderId, 'u1');
      expect(result.text, 'Hello');
      expect(result.imageUrl, 'img');
      expect(result.timestamp, timestamp);
    });

    test('parses missing values safely', () {
      final result = MessageModel.fromJson({});
      expect(result.messageId, '');
      expect(result.senderId, '');
      expect(result.text, '');
      expect(result.timestamp, isNull);
    });
  });
}
