import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentora/core/errors/exceptions.dart';
import 'package:rentora/core/errors/firebase_error_handler.dart';
import 'package:rentora/core/network/firebase/chats_firestore_service.dart';
import 'package:rentora/features/chat/data/models/message_model.dart';
import 'package:rentora/features/chat/data/models/chat_model.dart';

class ChatRepo {
  final ChatsFirestoreService _chatsFirestoreService;
  final FirebaseFirestore _firestore;

  ChatRepo(this._chatsFirestoreService, this._firestore);

  Stream<List<MessageModel>> getMessages(String chatId) {
    if (chatId.trim().isEmpty) {
      return Stream.value([]);
    }
    try {
      return _chatsFirestoreService.getChatMessagesStream(chatId: chatId).map((
        snapshot,
      ) {
        return snapshot.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList();
      });
    } catch (e) {
      throw ServerException(FirebaseErrorHandler.handle(e));
    }
  }

  Stream<List<ChatModel>> getUserChats(String userId) {
    if (userId.trim().isEmpty) {
      return Stream.value([]);
    }
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .snapshots()
        .map(
          (snapshot) {
            final chats = snapshot.docs
                .map((doc) => ChatModel.fromJson(doc.data()))
                .toList();
            chats.sort((a, b) {
              final aTime = a.lastMessageTime?.toDate() ?? DateTime(2000);
              final bTime = b.lastMessageTime?.toDate() ?? DateTime(2000);
              return bTime.compareTo(aTime);
            });
            return chats;
          },
        );
  }

  Future<String> createOrGetChat({
    required String bookingId,
    required String firstUserId,
    required String secondUserId,
    Map<String, String>? participantNames,
    Map<String, String>? participantAvatars,
    String? itemTitle,
    String? itemImageUrl,
  }) async {
    final cleanFirstId = firstUserId.trim();
    final cleanSecondId = secondUserId.trim();
    final cleanBookingId = bookingId.trim();

    if (cleanFirstId.isEmpty || cleanSecondId.isEmpty) {
      throw const ServerException(
        'Unable to start chat. User information is missing or incomplete.',
      );
    }

    if (cleanFirstId == cleanSecondId) {
      throw const ServerException('You cannot start a chat with yourself.');
    }

    try {
      final sortedParticipants = [cleanFirstId, cleanSecondId]..sort();
      final id = '${cleanBookingId.isEmpty ? 'chat' : cleanBookingId}_${sortedParticipants.join('_')}';

      final docRef = _firestore.collection('chats').doc(id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        final Map<String, dynamic> data = {
          'chatId': id,
          'bookingId': cleanBookingId,
          'participants': [cleanFirstId, cleanSecondId],
          'lastMessage': '',
          'lastMessageTime': FieldValue.serverTimestamp(),
        };
        if (participantNames != null) {
          data['participantNames'] = participantNames;
        }
        if (participantAvatars != null) {
          data['participantAvatars'] = participantAvatars;
        }
        if (itemTitle != null && itemTitle.isNotEmpty) {
          data['itemTitle'] = itemTitle;
        }
        if (itemImageUrl != null && itemImageUrl.isNotEmpty) {
          data['itemImageUrl'] = itemImageUrl;
        }

        await _chatsFirestoreService.createChatRoom(
          chatId: id,
          chatData: data,
        );
      }
      return id;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(FirebaseErrorHandler.handle(e));
    }
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    if (chatId.trim().isEmpty || senderId.trim().isEmpty || text.trim().isEmpty) {
      return;
    }
    try {
      final messageDocRef = _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc();

      final message = MessageModel(
        messageId: messageDocRef.id,
        senderId: senderId,
        text: text,
        timestamp: Timestamp.now(),
      );

      await _chatsFirestoreService.sendMessage(
        chatId: chatId,
        messageData: message.toJson(),
      );

      await _firestore.collection('chats').doc(chatId).update({
        'lastMessage': text,
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw ServerException(FirebaseErrorHandler.handle(e));
    }
  }
}
