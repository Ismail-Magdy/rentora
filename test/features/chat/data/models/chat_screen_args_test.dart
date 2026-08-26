import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/chat/data/models/chat_screen_args.dart';

void main() {
  group('ChatScreenArgs Tests', () {
    test('instantiates correctly with all fields', () {
      const args = ChatScreenArgs(
        chatId: 'chat_123',
        receiverName: 'Ahmed',
        receiverAvatar: 'https://example.com/avatar.jpg',
        itemTitle: 'Camera',
      );

      expect(args.chatId, 'chat_123');
      expect(args.receiverName, 'Ahmed');
      expect(args.receiverAvatar, 'https://example.com/avatar.jpg');
      expect(args.itemTitle, 'Camera');
    });

    test('instantiates correctly with minimal required fields', () {
      const args = ChatScreenArgs(chatId: 'chat_456');

      expect(args.chatId, 'chat_456');
      expect(args.receiverName, isNull);
      expect(args.receiverAvatar, isNull);
      expect(args.itemTitle, isNull);
    });
  });
}
