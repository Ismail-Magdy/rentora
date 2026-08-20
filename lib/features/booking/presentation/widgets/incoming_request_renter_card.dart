import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/chat/data/models/chat_screen_args.dart';
import 'package:rentora/features/chat/manager/chat_cubit.dart';

class IncomingRequestRenterCard extends StatelessWidget {
  final String renterName;
  final String avatarUrl;
  final String rating;
  final String reviewsCountText;
  final bool isVerified;
  final String? renterId;
  final String? bookingId;
  final String? itemTitle;
  final VoidCallback? onChatPressed;

  const IncomingRequestRenterCard({
    super.key,
    required this.renterName,
    required this.avatarUrl,
    required this.rating,
    required this.reviewsCountText,
    this.isVerified = true,
    this.renterId,
    this.bookingId,
    this.itemTitle,
    this.onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Renter Information',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
          verticalSpace(12),
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: AppColors.lightGrey,
                backgroundImage: avatarUrl.isNotEmpty
                    ? NetworkImage(avatarUrl)
                    : null,
                child: avatarUrl.isEmpty
                    ? const Icon(Icons.person, color: AppColors.grey)
                    : null,
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            renterName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        horizontalSpace(6),
                        if (isVerified)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.successLight,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified,
                                  size: 12.r,
                                  color: AppColors.successDark,
                                ),
                                horizontalSpace(3),
                                Text(
                                  'Verified',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.successDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    verticalSpace(4),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 16.r,
                          color: AppColors.warning,
                        ),
                        horizontalSpace(4),
                        Text(
                          '$rating ($reviewsCountText)',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              horizontalSpace(8),
              CustomButton(
                borderRadius: 10,
                text: "Chat",
                icon: Icons.chat_bubble_outline_rounded,
                width: 82.w,
                height: 38.h,
                fontSize: 12.sp,
                onPressed: () async {
                  if (onChatPressed != null) {
                    onChatPressed!();
                    return;
                  }

                  final user = getIt<FirebaseAuth>().currentUser;
                  if (user == null) {
                    showFeedbackDialog(
                      context,
                      icon: Icons.lock_outline_rounded,
                      color: AppColors.primaryColor,
                      title: 'Login Required',
                      message: 'Please log in first to chat with the renter.',
                      onFinish: () => context.pushNamed(Routes.loginScreen),
                    );
                    return;
                  }

                  final currentUserId = user.uid;
                  final targetRenterId = (renterId ?? '').trim().isNotEmpty
                      ? renterId!.trim()
                      : 'renter_${renterName.replaceAll(' ', '_').toLowerCase()}';

                  if (targetRenterId.isEmpty) {
                    showFeedbackDialog(
                      context,
                      icon: Icons.info_outline_rounded,
                      color: AppColors.warning,
                      title: 'Unavailable',
                      message: 'Renter information is currently unavailable.',
                    );
                    return;
                  }

                  if (currentUserId == targetRenterId) {
                    showFeedbackDialog(
                      context,
                      icon: Icons.info_outline_rounded,
                      color: AppColors.primaryColor,
                      title: 'Notice',
                      message: 'You cannot start a chat with yourself.',
                    );
                    return;
                  }

                  final targetBookingId = (bookingId ?? '').trim().isNotEmpty
                      ? bookingId!.trim()
                      : 'booking_sample';
                  final currentUserName = user.displayName ??
                      user.email?.split('@').first ??
                      'Owner';

                  try {
                    final chatId = await getIt<ChatCubit>().createOrGetChat(
                      bookingId: targetBookingId,
                      firstUserId: currentUserId,
                      secondUserId: targetRenterId,
                      participantNames: {
                        currentUserId: currentUserName,
                        targetRenterId: renterName,
                      },
                      participantAvatars: {
                        if (avatarUrl.isNotEmpty) targetRenterId: avatarUrl,
                        if (user.photoURL != null && user.photoURL!.isNotEmpty)
                          currentUserId: user.photoURL!,
                      },
                      itemTitle: itemTitle,
                    );

                    if (context.mounted) {
                      context.pushNamed(
                        Routes.chatScreen,
                        arguments: ChatScreenArgs(
                          chatId: chatId,
                          receiverName: renterName,
                          receiverAvatar:
                              avatarUrl.isNotEmpty ? avatarUrl : null,
                          itemTitle: itemTitle,
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      showFeedbackDialog(
                        context,
                        icon: Icons.error_outline_rounded,
                        color: AppColors.error,
                        title: 'Error',
                        message:
                            'Failed to start conversation. Please try again.',
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

