import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/chat/data/models/chat_model.dart';

class ChatTile extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.chat,
    required this.onTap,
  });

  String _getOtherParticipantId(String currentUserId) {
    return chat.participants.firstWhere(
      (id) => id != currentUserId,
      orElse: () => '',
    );
  }

  String _getOtherParticipantName(String otherId) {
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

  String? _getOtherParticipantAvatar(String otherId) {
    if (chat.participantAvatars != null &&
        chat.participantAvatars!.containsKey(otherId)) {
      return chat.participantAvatars![otherId];
    }
    return chat.itemImageUrl;
  }

  String _formatTimestamp(DateTime? dateTime) {
    if (dateTime == null) return '';
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return weekdays[dateTime.weekday - 1];
    } else {
      return '${dateTime.day}/${dateTime.month}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final otherId = _getOtherParticipantId(currentUserId);
    final displayName = _getOtherParticipantName(otherId);
    final avatarUrl = _getOtherParticipantAvatar(otherId);
    final formattedTime = _formatTimestamp(chat.lastMessageTime?.toDate());

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26.r,
                  backgroundColor: AppColors.primaryColor.withValues(
                    alpha: 0.1,
                  ),
                  backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                      ? NetworkImage(avatarUrl)
                      : null,
                  child: avatarUrl == null || avatarUrl.isEmpty
                      ? Text(
                          displayName.isNotEmpty
                              ? displayName[0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        )
                      : null,
                ),
                horizontalSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          if (formattedTime.isNotEmpty)
                            Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: AppColors.darkGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                      verticalSpace(4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat.lastMessage.isEmpty
                                  ? 'Start a conversation...'
                                  : chat.lastMessage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: chat.lastMessage.isEmpty
                                    ? AppColors.primaryColor
                                    : AppColors.grey,
                                fontWeight: chat.lastMessage.isEmpty
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                horizontalSpace(8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.sp,
                  color: AppColors.grey.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

