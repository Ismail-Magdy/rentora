import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/features/chat/data/models/chat_screen_args.dart';
import 'package:rentora/features/chat/manager/chat_cubit.dart';
import 'package:rentora/core/routing/routes.dart';

class OwnerInfoCard extends StatelessWidget {
  final ItemDetailsModel item;

  const OwnerInfoCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F9),
        borderRadius: .circular(12.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundImage: NetworkImage(item.ownerAvatar),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Text(
                      item.ownerName,
                      style: TextStyle(fontSize: 14.sp, fontWeight: .bold),
                    ),
                    horizontalSpace(4),
                    if (item.isSuperHost)
                      Icon(
                        Icons.verified,
                        color: AppColors.primaryColor,
                        size: 14.sp,
                      ),
                  ],
                ),
                verticalSpace(4),
                Row(
                  children: [
                    Text(
                      'Rental Confirmed',
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                    horizontalSpace(8),
                    Text(
                      item.ownerRating.toString(),
                      style: TextStyle(fontSize: 10.sp, fontWeight: .bold),
                    ),
                    Icon(Icons.star, color: Colors.orange, size: 10.sp),
                  ],
                ),
              ],
            ),
          ),

          //
          CustomButton(
            borderRadius: 10,
            text: "Contact",
            width: 100,
            height: 41,
            onPressed: () async {
              final user = getIt<FirebaseAuth>().currentUser;
              if (user == null) {
                showFeedbackDialog(
                  context,
                  icon: Icons.lock_outline_rounded,
                  color: AppColors.primaryColor,
                  title: 'Login Required',
                  message:
                      'Please log in first to contact the owner and start chatting.',
                  onFinish: () => context.pushNamed(Routes.loginScreen),
                );
                return;
              }

              final ownerId = item.ownerId.trim();
              if (ownerId.isEmpty || ownerId == 'dummy' || ownerId == 'null') {
                showFeedbackDialog(
                  context,
                  icon: Icons.info_outline_rounded,
                  color: AppColors.warning,
                  title: 'Unavailable',
                  message:
                      'Owner information is currently unavailable for this item.',
                );
                return;
              }

              if (user.uid == ownerId) {
                showFeedbackDialog(
                  context,
                  icon: Icons.info_outline_rounded,
                  color: AppColors.primaryColor,
                  title: 'Notice',
                  message:
                      'You cannot start a chat with yourself for your own listing.',
                );
                return;
              }

              try {
                final currentUserName =
                    user.displayName ?? user.email?.split('@').first ?? 'User';

                final chatId = await getIt<ChatCubit>().createOrGetChat(
                  bookingId: item.id,
                  firstUserId: user.uid,
                  secondUserId: ownerId,
                  participantNames: {
                    user.uid: currentUserName,
                    ownerId: item.ownerName,
                  },
                  participantAvatars: {
                    if (item.ownerAvatar.isNotEmpty) ownerId: item.ownerAvatar,
                    if (user.photoURL != null && user.photoURL!.isNotEmpty)
                      user.uid: user.photoURL!,
                  },
                  itemTitle: item.name,
                  itemImageUrl: item.imageUrls.isNotEmpty
                      ? item.imageUrls.first
                      : null,
                );

                if (context.mounted) {
                  context.pushNamed(
                    Routes.chatScreen,
                    arguments: ChatScreenArgs(
                      chatId: chatId,
                      receiverName: item.ownerName,
                      receiverAvatar: item.ownerAvatar,
                      itemTitle: item.name,
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
                    message: 'Failed to start conversation. Please try again.',
                  );
                }
              }
            },
          ),

          //
        ],
      ),
    );
  }
}
