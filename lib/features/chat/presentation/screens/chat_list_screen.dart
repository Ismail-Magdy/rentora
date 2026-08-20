import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar_without_leading.dart';
import 'package:rentora/features/chat/data/models/chat_model.dart';
import 'package:rentora/features/chat/data/models/chat_screen_args.dart';
import 'package:rentora/features/chat/manager/chat_cubit.dart';
import 'package:rentora/features/chat/manager/chat_state.dart';
import 'package:rentora/features/chat/presentation/widgets/chat_empty_state.dart';
import 'package:rentora/features/chat/presentation/widgets/chat_tile.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId != null) {
      context.read<ChatCubit>().listenToChats(currentUserId);
    }
  }

  String _getOtherParticipantId(ChatModel chat, String currentUserId) {
    return chat.participants.firstWhere(
      (id) => id != currentUserId,
      orElse: () => '',
    );
  }

  String _getOtherParticipantName(ChatModel chat, String otherId) {
    if (chat.participantNames != null &&
        chat.participantNames!.containsKey(otherId)) {
      final name = chat.participantNames![otherId];
      if (name != null && name.toString().isNotEmpty) {
        return name.toString();
      }
    }
    if (chat.itemTitle != null && chat.itemTitle!.isNotEmpty) {
      return chat.itemTitle!;
    }
    return otherId.isNotEmpty
        ? 'User ${otherId.substring(0, otherId.length > 5 ? 5 : otherId.length)}'
        : 'Chat';
  }

  String? _getOtherParticipantAvatar(ChatModel chat, String otherId) {
    if (chat.participantAvatars != null &&
        chat.participantAvatars!.containsKey(otherId)) {
      return chat.participantAvatars![otherId];
    }
    return chat.itemImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (currentUserId.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: CustomAppBarWithNoLeading(text: 'Chats'),
        body: ChatEmptyState(
          title: 'Login to View Chats',
          message:
              'Please log in to your account to view your conversations and messages.',
          icon: Icons.lock_outline_rounded,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const CustomAppBarWithNoLeading(text: 'Chats'),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is ChatError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.error, fontSize: 14.sp),
                ),
              ),
            );
          }

          if (state is ChatListLoaded) {
            if (state.chats.isEmpty) {
              return const ChatEmptyState(
                title: 'No chats yet',
                message:
                    'When you contact an owner or receive an inquiry, your conversations will appear here.',
                icon: Icons.chat_bubble_outline_rounded,
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                final chat = state.chats[index];
                final otherId = _getOtherParticipantId(chat, currentUserId);
                final receiverName = _getOtherParticipantName(chat, otherId);
                final receiverAvatar = _getOtherParticipantAvatar(
                  chat,
                  otherId,
                );

                return ChatTile(
                  chat: chat,
                  onTap: () {
                    context.pushNamed(
                      Routes.chatScreen,
                      arguments: ChatScreenArgs(
                        chatId: chat.chatId,
                        receiverName: receiverName,
                        receiverAvatar: receiverAvatar,
                        itemTitle: chat.itemTitle,
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
