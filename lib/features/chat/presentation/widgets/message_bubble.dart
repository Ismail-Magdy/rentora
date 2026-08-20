import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/chat/data/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMine;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMine,
  });

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = _formatTime(message.timestamp?.toDate());

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 0.78 * MediaQuery.sizeOf(context).width,
        ),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isMine ? AppColors.primaryColor : AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.r),
            topRight: Radius.circular(18.r),
            bottomLeft: Radius.circular(isMine ? 18.r : 4.r),
            bottomRight: Radius.circular(isMine ? 4.r : 18.r),
          ),
          border: isMine
              ? null
              : Border.all(
                  color: AppColors.dividerColor,
                  width: 1.w,
                ),
          boxShadow: [
            BoxShadow(
              color: isMine
                  ? AppColors.primaryColor.withValues(alpha: 0.18)
                  : AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (message.imageUrl != null &&
                message.imageUrl!.trim().isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  message.imageUrl!,
                  width: double.infinity,
                  height: 180.h,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 180.h,
                      color: AppColors.lightGrey.withValues(alpha: 0.3),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          color: isMine
                              ? AppColors.white
                              : AppColors.primaryColor,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 140.h,
                    color: AppColors.lightGrey.withValues(alpha: 0.3),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image_rounded,
                            size: 32.sp,
                            color: AppColors.grey,
                          ),
                          verticalSpace(4),
                          Text(
                            'Failed to load image',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (message.text.isNotEmpty) verticalSpace(8),
            ],
            if (message.text.isNotEmpty)
              Text(
                message.text,
                style: TextStyle(
                  color: isMine ? AppColors.white : AppColors.black,
                  fontSize: 14.5.sp,
                  height: 1.35,
                  fontWeight: FontWeight.w400,
                ),
              ),
            if (formattedTime.isNotEmpty) ...[
              verticalSpace(4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formattedTime,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: isMine
                          ? AppColors.white.withValues(alpha: 0.75)
                          : AppColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (isMine) ...[
                    horizontalSpace(4),
                    Icon(
                      Icons.done_all_rounded,
                      size: 13.sp,
                      color: AppColors.white.withValues(alpha: 0.85),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

