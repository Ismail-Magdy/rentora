import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/exceptions.dart';
import 'package:rentora/core/network/firebase/chats_firestore_service.dart';
import 'package:rentora/core/network/firebase/cloudinary_service.dart';
import 'package:rentora/features/chat/data/repo/chat_repo_imp.dart';

class MockChatsFirestoreService extends Mock implements ChatsFirestoreService {}

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCloudinaryService extends Mock implements CloudinaryService {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockChatsFirestoreService mockChatsService;
  late MockFirestore mockFirestore;
  late MockCloudinaryService mockCloudinaryService;
  late MockCollectionReference mockChatsCollection;
  late MockDocumentReference mockChatDoc;
  late MockDocumentSnapshot mockChatDocSnapshot;
  late ChatRepo chatRepo;

  setUp(() {
    mockChatsService = MockChatsFirestoreService();
    mockFirestore = MockFirestore();
    mockCloudinaryService = MockCloudinaryService();
    mockChatsCollection = MockCollectionReference();
    mockChatDoc = MockDocumentReference();
    mockChatDocSnapshot = MockDocumentSnapshot();

    when(
      () => mockFirestore.collection('chats'),
    ).thenReturn(mockChatsCollection);
    when(() => mockChatsCollection.doc(any())).thenReturn(mockChatDoc);

    chatRepo = ChatRepo(mockChatsService, mockFirestore, mockCloudinaryService);
  });

  group('ChatRepo Tests', () {
    test('getMessages returns empty stream if chatId is empty', () async {
      final stream = chatRepo.getMessages('   ');
      final result = await stream.first;
      expect(result, isEmpty);
    });

    test('getUserChats returns empty stream if userId is empty', () async {
      final stream = chatRepo.getUserChats('');
      final result = await stream.first;
      expect(result, isEmpty);
    });

    test(
      'createOrGetChat throws ServerException when same user id is passed',
      () async {
        expect(
          () => chatRepo.createOrGetChat(
            bookingId: 'book_1',
            firstUserId: 'u1',
            secondUserId: 'u1',
          ),
          throwsA(isA<ServerException>()),
        );
      },
    );

    test('createOrGetChat creates chat room if doc does not exist', () async {
      when(
        () => mockChatDoc.get(),
      ).thenAnswer((_) async => mockChatDocSnapshot);
      when(() => mockChatDocSnapshot.exists).thenReturn(false);
      when(
        () => mockChatsService.createChatRoom(
          chatId: any(named: 'chatId'),
          chatData: any(named: 'chatData'),
        ),
      ).thenAnswer((_) async {});

      final chatId = await chatRepo.createOrGetChat(
        bookingId: 'book_100',
        firstUserId: 'user_a',
        secondUserId: 'user_b',
        participantNames: {'user_a': 'Alice', 'user_b': 'Bob'},
      );

      expect(chatId, 'book_100_user_a_user_b');
      verify(
        () => mockChatsService.createChatRoom(
          chatId: 'book_100_user_a_user_b',
          chatData: any(named: 'chatData'),
        ),
      ).called(1);
    });

    test('uploadChatImage delegates to CloudinaryService', () async {
      final file = File('test.jpg');
      when(
        () => mockCloudinaryService.uploadImage(file),
      ).thenAnswer((_) async => 'https://cloudinary.com/test.jpg');

      final result = await chatRepo.uploadChatImage(file);
      expect(result, 'https://cloudinary.com/test.jpg');
    });
  });
}
