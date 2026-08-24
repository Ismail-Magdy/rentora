import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/chat/manager/chat_cubit.dart';
import 'package:rentora/features/chat/manager/chat_state.dart';
import 'package:rentora/features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:rentora/features/chat/presentation/widgets/chat_empty_state.dart';
import 'package:rentora/features/chat/presentation/widgets/chat_input_bar.dart';
import 'package:rentora/features/chat/presentation/widgets/message_bubble.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String? receiverName;
  final String? receiverAvatar;
  final String? itemTitle;

  const ChatScreen({
    super.key,
    required this.chatId,
    this.receiverName,
    this.receiverAvatar,
    this.itemTitle,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.chatId.trim().isNotEmpty) {
      context.read<ChatCubit>().listenToMessages(widget.chatId.trim());
    }
  }

  void _onSendMessage(String text) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null &&
        text.trim().isNotEmpty &&
        widget.chatId.trim().isNotEmpty) {
      context.read<ChatCubit>().sendMessage(
        chatId: widget.chatId.trim(),
        senderId: user.uid,
        text: text,
      );
    }
  }

  void _onSendImage(File imageFile, String caption) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && widget.chatId.trim().isNotEmpty) {
      context.read<ChatCubit>().sendImageMessage(
        chatId: widget.chatId.trim(),
        senderId: user.uid,
        imageFile: imageFile,
        text: caption,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final titleText = widget.receiverName ?? widget.itemTitle ?? 'Conversation';

    if (widget.chatId.trim().isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: ChatAppBar(
          receiverName: titleText,
          receiverAvatar: widget.receiverAvatar,
          itemTitle: widget.itemTitle,
        ),
        body: ChatEmptyState(
          title: l10n.invalidChat,
          message: l10n.invalidChatMessage,
          icon: Icons.error_outline_rounded,
        ),
      );
    }

    return BlocListener<ChatCubit, ChatState>(
      listenWhen: (previous, current) =>
          current is ChatImageUploadSuccess || current is ChatError,
      listener: (context, state) {
        if (state is ChatImageUploadSuccess) {
          showFeedbackDialog(
            context,
            icon: Icons.check_circle_outline,
            color: AppColors.primaryColor,
            title: 'Success',
            message: 'Image sent successfully',
          );
        } else if (state is ChatError) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline,
            color: Colors.red,
            title: 'Error',
            message: state.message,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: ChatAppBar(
          receiverName: titleText,
          receiverAvatar: widget.receiverAvatar,
          itemTitle: widget.itemTitle,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                buildWhen: (previous, current) =>
                    current is ChatMessagesLoaded || current is ChatLoading,
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }

                  if (state is ChatError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.error,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is ChatMessagesLoaded) {
                    if (state.messages.isEmpty) {
                      return ChatEmptyState(
                        title: l10n.noMessages,
                        message: l10n.startConversation,
                        icon: Icons.chat_bubble_outline_rounded,
                      );
                    }

                    return ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message =
                            state.messages[state.messages.length - 1 - index];
                        final isMine = message.senderId == currentUserId;

                        return MessageBubble(message: message, isMine: isMine);
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
            BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                final isUploading = state is ChatImageUploading;
                return ChatInputBar(
                  onSendMessage: _onSendMessage,
                  onSendImage: _onSendImage,
                  isSending: isUploading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
