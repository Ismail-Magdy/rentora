import 'package:rentora/features/chat/data/models/chat_model.dart';
import 'package:rentora/features/chat/data/models/message_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatListLoaded extends ChatState {
  final List<ChatModel> chats;
  ChatListLoaded(this.chats);
}

class ChatMessagesLoaded extends ChatState {
  final List<MessageModel> messages;
  ChatMessagesLoaded(this.messages);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
