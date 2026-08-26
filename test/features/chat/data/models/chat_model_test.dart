import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/chat/data/models/chat_model.dart';

void main() {
  group('ChatModel', () {
    test('serializes and parses complete chat data', () {
      final time = Timestamp.fromDate(DateTime(2026, 1, 1));
      final model = ChatModel(
        chatId: 'c1',
        bookingId: 'b1',
        participants: const ['u1', 'u2'],
        lastMessage: 'Hi',
        lastMessageTime: time,
        participantNames: const {'u1': 'Ali'},
        itemTitle: 'Camera',
      );
      final result = ChatModel.fromJson(model.toJson());
      expect(result.chatId, 'c1');
      expect(result.participants, ['u1', 'u2']);
      expect(result.lastMessageTime, time);
      expect(result.participantNames?['u1'], 'Ali');
      expect(result.itemTitle, 'Camera');
    });

    test('handles missing optional data', () {
      final result = ChatModel.fromJson({});
      expect(result.chatId, '');
      expect(result.participants, isEmpty);
      expect(result.lastMessageTime, isNull);
    });
  });
}
