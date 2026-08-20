import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final String bookingId;
  final List<String> participants;
  final String lastMessage;
  final Timestamp? lastMessageTime;
  final Map<String, dynamic>? participantNames;
  final Map<String, dynamic>? participantAvatars;
  final String? itemTitle;
  final String? itemImageUrl;

  ChatModel({
    required this.chatId,
    required this.bookingId,
    required this.participants,
    required this.lastMessage,
    this.lastMessageTime,
    this.participantNames,
    this.participantAvatars,
    this.itemTitle,
    this.itemImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'bookingId': bookingId,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime ?? FieldValue.serverTimestamp(),
      if (participantNames != null) 'participantNames': participantNames,
      if (participantAvatars != null) 'participantAvatars': participantAvatars,
      if (itemTitle != null) 'itemTitle': itemTitle,
      if (itemImageUrl != null) 'itemImageUrl': itemImageUrl,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chatId'] ?? '',
      bookingId: json['bookingId'] ?? '',
      participants: List<String>.from(json['participants'] ?? []),
      lastMessage: json['lastMessage'] ?? '',
      lastMessageTime: json['lastMessageTime'] is Timestamp
          ? json['lastMessageTime'] as Timestamp
          : null,
      participantNames: json['participantNames'] != null
          ? Map<String, dynamic>.from(json['participantNames'])
          : null,
      participantAvatars: json['participantAvatars'] != null
          ? Map<String, dynamic>.from(json['participantAvatars'])
          : null,
      itemTitle: json['itemTitle'],
      itemImageUrl: json['itemImageUrl'],
    );
  }
}

