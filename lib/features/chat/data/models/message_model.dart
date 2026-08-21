import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String senderId;
  final String text;
  final String? imageUrl;
  final Timestamp? timestamp;

  MessageModel({
    required this.messageId,
    required this.senderId,
    required this.text,
    this.imageUrl,
    this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'text': text,
      if (imageUrl != null && imageUrl!.isNotEmpty) 'imageUrl': imageUrl,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['messageId'] ?? '',
      senderId: json['senderId'] ?? '',
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'],
      timestamp: json['timestamp'] is Timestamp
          ? json['timestamp'] as Timestamp
          : null,
    );
  }
}

