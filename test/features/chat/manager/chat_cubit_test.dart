import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/exceptions.dart';
import 'package:rentora/features/chat/data/models/chat_model.dart';
import 'package:rentora/features/chat/data/models/message_model.dart';
import 'package:rentora/features/chat/data/repo/chat_repo_imp.dart';
import 'package:rentora/features/chat/manager/chat_cubit.dart';
import 'package:rentora/features/chat/manager/chat_state.dart';

class MockChatRepo extends Mock implements ChatRepo {}

void main() {
  setUpAll(() {
    registerFallbackValue(File('dummy.jpg'));
  });

  late MockChatRepo mockChatRepo;
  late ChatCubit chatCubit;

  setUp(() {
    mockChatRepo = MockChatRepo();
    chatCubit = ChatCubit(mockChatRepo);
  });

  tearDown(() {
    chatCubit.close();
  });

  final tMessage = MessageModel(
    messageId: 'msg_1',
    senderId: 'user_1',
    text: 'Hello!',
    timestamp: Timestamp.now(),
  );

  final tChat = ChatModel(
    chatId: 'chat_1',
    bookingId: 'book_1',
    participants: ['user_1', 'user_2'],
    lastMessage: 'Hello!',
  );

  group('ChatCubit Tests', () {
    test('initial state is ChatInitial', () {
      expect(chatCubit.state, isA<ChatInitial>());
    });

    test('listenToChats emits ChatLoading and ChatListLoaded', () async {
      when(
        () => mockChatRepo.getUserChats('user_1'),
      ).thenAnswer((_) => Stream.value([tChat]));

      final states = <ChatState>[];
      chatCubit.stream.listen(states.add);

      chatCubit.listenToChats('user_1');
      await Future.delayed(const Duration(milliseconds: 50));

      expect(states.length, 2);
      expect(states[0], isA<ChatLoading>());
      expect(states[1], isA<ChatListLoaded>());
      expect((states[1] as ChatListLoaded).chats, [tChat]);
    });

    test('listenToMessages emits ChatLoading and ChatMessagesLoaded', () async {
      when(
        () => mockChatRepo.getMessages('chat_1'),
      ).thenAnswer((_) => Stream.value([tMessage]));

      final states = <ChatState>[];
      chatCubit.stream.listen(states.add);

      chatCubit.listenToMessages('chat_1');
      await Future.delayed(const Duration(milliseconds: 50));

      expect(states.length, 2);
      expect(states[0], isA<ChatLoading>());
      expect(states[1], isA<ChatMessagesLoaded>());
      expect((states[1] as ChatMessagesLoaded).messages, [tMessage]);
    });

    test('sendMessage calls repo sendMessage', () async {
      when(
        () => mockChatRepo.sendMessage(
          chatId: 'chat_1',
          senderId: 'user_1',
          text: 'Hello',
          imageUrl: null,
        ),
      ).thenAnswer((_) async {});

      await chatCubit.sendMessage(
        chatId: 'chat_1',
        senderId: 'user_1',
        text: 'Hello',
      );

      verify(
        () => mockChatRepo.sendMessage(
          chatId: 'chat_1',
          senderId: 'user_1',
          text: 'Hello',
          imageUrl: null,
        ),
      ).called(1);
    });

    blocTest<ChatCubit, ChatState>(
      'sendImageMessage emits ChatImageUploading and ChatImageUploadSuccess on success',
      build: () {
        when(
          () => mockChatRepo.uploadChatImage(any()),
        ).thenAnswer((_) async => 'https://img.com/test.jpg');
        when(
          () => mockChatRepo.sendMessage(
            chatId: any(named: 'chatId'),
            senderId: any(named: 'senderId'),
            text: any(named: 'text'),
            imageUrl: any(named: 'imageUrl'),
          ),
        ).thenAnswer((_) async {});
        return chatCubit;
      },
      act: (cubit) => cubit.sendImageMessage(
        chatId: 'chat_1',
        senderId: 'user_1',
        imageFile: File('test.jpg'),
      ),
      expect: () => [
        isA<ChatImageUploading>(),
        isA<ChatImageUploadSuccess>(),
      ],
    );

    blocTest<ChatCubit, ChatState>(
      'sendImageMessage emits ChatError on failure',
      build: () {
        when(
          () => mockChatRepo.uploadChatImage(any()),
        ).thenThrow(const ServerException('Upload failed'));
        return chatCubit;
      },
      act: (cubit) => cubit.sendImageMessage(
        chatId: 'chat_1',
        senderId: 'user_1',
        imageFile: File('test.jpg'),
      ),
      expect: () => [
        isA<ChatImageUploading>(),
        isA<ChatError>(),
      ],
    );
  });
}
