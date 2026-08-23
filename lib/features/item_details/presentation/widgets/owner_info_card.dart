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
import 'package:rentora/l10n/generated/app_localizations.dart';

class OwnerInfoCard extends StatelessWidget {
  final ItemDetailsModel item;

  const OwnerInfoCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: .all(12.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : const Color(0xFFF7F7F9),
        borderRadius: .circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
            backgroundImage: item.ownerAvatar.isNotEmpty ? NetworkImage(item.ownerAvatar) : null,
            child: item.ownerAvatar.isEmpty
                ? Icon(Icons.person, color: AppColors.primaryColor)
                : null,
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      item.ownerName.isNotEmpty ? item.ownerName : 'Unknown Owner',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                      ),
                    ),
                    if (item.ownerVerificationStatus == 'verified') ...[
                      horizontalSpace(4),
                      Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 18.sp,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          //
          CustomButton(
            borderRadius: 10,
            text: l10n.contact,
            width: 100,
            height: 41,
            onPressed: () async {
              final user = getIt<FirebaseAuth>().currentUser;
              if (user == null) {
                showFeedbackDialog(
                  context,
                  icon: Icons.lock_outline_rounded,
                  color: AppColors.primaryColor,
                  title: l10n.loginRequiredTitle,
                  message: l10n.loginRequiredContact,
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
                  title: l10n.unavailable,
                  message: l10n.ownerUnavailable,
                );
                return;
              }

              if (user.uid == ownerId) {
                showFeedbackDialog(
                  context,
                  icon: Icons.info_outline_rounded,
                  color: AppColors.primaryColor,
                  title: l10n.notice,
                  message: l10n.cannotChatSelfListing,
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
                    title: l10n.error,
                    message: l10n.conversationFailed,
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
