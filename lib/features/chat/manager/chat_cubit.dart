import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/errors/exceptions.dart';
import 'package:rentora/core/errors/firebase_error_handler.dart';
import 'package:rentora/features/chat/data/models/chat_model.dart';
import 'package:rentora/features/chat/data/models/message_model.dart';
import 'package:rentora/features/chat/data/repo/chat_repo_imp.dart';

import 'package:rentora/features/chat/manager/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo _chatRepo;
  StreamSubscription<List<MessageModel>>? _messagesSubscription;
  StreamSubscription<List<ChatModel>>? _chatsSubscription;

  ChatCubit(this._chatRepo) : super(ChatInitial());

  void listenToChats(String userId) {
    emit(ChatLoading());
    _chatsSubscription?.cancel();
    _chatsSubscription = _chatRepo
        .getUserChats(userId)
        .listen(
          (chats) => emit(ChatListLoaded(chats)),
          onError: (error) =>
              emit(ChatError(FirebaseErrorHandler.handle(error))),
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
  }) => _chatRepo.createOrGetChat(
    bookingId: bookingId,
    firstUserId: firstUserId,
    secondUserId: secondUserId,
    participantNames: participantNames,
    participantAvatars: participantAvatars,
    itemTitle: itemTitle,
    itemImageUrl: itemImageUrl,
  );

  void listenToMessages(String chatId) {
    emit(ChatLoading());
    try {
      _messagesSubscription?.cancel();
      _messagesSubscription = _chatRepo
          .getMessages(chatId)
          .listen(
            (messages) {
              emit(ChatMessagesLoaded(messages));
            },
            onError: (error) {
              emit(ChatError(FirebaseErrorHandler.handle(error)));
            },
          );
    } catch (e) {
      emit(ChatError(FirebaseErrorHandler.handle(e)));
    }
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    if (text.trim().isEmpty) return;

    try {
      await _chatRepo.sendMessage(
        chatId: chatId,
        senderId: senderId,
        text: text,
      );
    } catch (e) {
      String errorMessage = "Failed to send message";
      if (e is ServerException) {
        errorMessage = e.message;
      } else {
        errorMessage = FirebaseErrorHandler.handle(e);
      }
      emit(ChatError(errorMessage));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _chatsSubscription?.cancel();
    return super.close();
  }
}
