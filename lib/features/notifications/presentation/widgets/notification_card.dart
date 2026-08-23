import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/notifications/data/models/notification_model.dart';
import 'package:rentora/features/notifications/manager/notifications_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  String _timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) return "${(diff.inDays / 365).floor()}y ago";
    if (diff.inDays > 30) return "${(diff.inDays / 30).floor()}mo ago";
    if (diff.inDays > 7) return "${(diff.inDays / 7).floor()}w ago";
    if (diff.inDays > 0) return "${diff.inDays}d ago";
    if (diff.inHours > 0) return "${diff.inHours}h ago";
    if (diff.inMinutes > 0) return "${diff.inMinutes}m ago";
    return "just now";
  }

  @override
  Widget build(BuildContext context) {
    final isChat = notification.type == 'chat';
    final iconData = isChat ? Icons.chat_bubble_outline : Icons.event_available;
    final timeString = notification.createdAt != null
        ? _timeAgo(notification.createdAt!.toDate())
        : '';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        if (!notification.isRead) {
          context.read<NotificationsCubit>().markAsRead(notification.id);
        }

        if (isChat) {
          context.pushNamed(Routes.chatScreen, arguments: notification.relatedId);
        } else {
          context.pushNamed(Routes.incomingRentalRequestScreen);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: notification.isRead
              ? (isDark ? AppColors.darkSurface : AppColors.white)
              : (isDark
                  ? AppColors.secondaryColor.withValues(alpha: 0.12)
                  : AppColors.primaryColor.withValues(alpha: 0.05)),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: notification.isRead
                ? (isDark ? AppColors.darkBorder : Colors.grey.shade200)
                : (isDark
                    ? AppColors.secondaryColor.withValues(alpha: 0.4)
                    : AppColors.primaryColor.withValues(alpha: 0.3)),
          ),
          boxShadow: [
            if (!notification.isRead)
              BoxShadow(
                color: isDark
                    ? AppColors.darkShadow
                    : AppColors.primaryColor.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: isChat
                    ? (isDark ? Colors.blue.withValues(alpha: 0.2) : Colors.blue.shade50)
                    : (isDark ? Colors.green.withValues(alpha: 0.2) : Colors.green.shade50),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: isChat ? Colors.blue : Colors.green,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: notification.isRead
                                ? FontWeight.w500
                                : FontWeight.bold,
                            color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                          ),
                        ),
                      ),
                      Text(
                        timeString,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark ? AppColors.darkTextMuted : AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    notification.body,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                      fontWeight: notification.isRead
                          ? FontWeight.normal
                          : FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
