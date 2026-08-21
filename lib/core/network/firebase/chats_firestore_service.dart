import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsFirestoreService {
  final FirebaseFirestore _firestore;

  ChatsFirestoreService(this._firestore);

  /// Creates a new chat room between the owner and the renter after booking approval
  Future<void> createChatRoom({
    required String chatId,
    required Map<String, dynamic> chatData,
  }) async {
    await _firestore
        .collection("chats")
        .doc(chatId)
        .set(chatData, SetOptions(merge: true));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserChatsStream({
    required String userId,
  }) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
  }

  /// Sends a new message inside a specific chat room
  Future<void> sendMessage({
    required String chatId,
    required Map<String, dynamic> messageData,
  }) async {
    await _firestore
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .add(messageData);
  }

  /// Listens to messages in real-time. Returns a Stream of data
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessagesStream({
    required String chatId,
  }) {
    return _firestore
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  /*
  CLASS SUMMARY:
  This class is responsible for the real-time communication feature. It creates
  chat sessions tied to specific bookings, handles sending messages to subcollections,
  and returns live Streams to update the UI instantly without refreshing.
  */
}
