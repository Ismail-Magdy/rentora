import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String receiverName;
  final String? receiverAvatar;
  final String? itemTitle;

  const ChatAppBar({
    super.key,
    required this.receiverName,
    this.receiverAvatar,
    this.itemTitle,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final hasAvatar = receiverAvatar != null && receiverAvatar!.isNotEmpty;

    return AppBar(
      backgroundColor: AppColors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => context.pop(),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.primaryColor,
        ),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: 19.r,
            backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
            backgroundImage: hasAvatar ? NetworkImage(receiverAvatar!) : null,
            child: !hasAvatar
                ? Text(
                    receiverName.isNotEmpty
                        ? receiverName[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  )
                : null,
          ),
          horizontalSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  receiverName.isNotEmpty ? receiverName : 'Conversation',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                if (itemTitle != null && itemTitle!.isNotEmpty) ...[
                  verticalSpace(2),
                  Text(
                    itemTitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
