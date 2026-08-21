import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/notifications/manager/notifications_cubit.dart';
import 'package:rentora/features/notifications/manager/notifications_state.dart';
import 'package:rentora/features/notifications/presentation/widgets/notification_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          scrolledUnderElevation: 0,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryColor,
            ),
          ),
          title: Text(
            "Notifications",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.grey,
            indicatorColor: AppColors.primaryColor,
            tabs: const [
              Tab(text: "Unread"),
              Tab(text: "Read"),
            ],
          ),
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsError) {
              return Center(child: Text(state.message));
            }

            final isLoading =
                state is NotificationsLoading || state is NotificationsInitial;

            final unreadList = state is NotificationsLoaded
                ? state.unreadNotifications
                : [];
            final readList = state is NotificationsLoaded
                ? state.readNotifications
                : [];

            return TabBarView(
              children: [
                _buildList(unreadList, isLoading, true),
                _buildList(readList, isLoading, false),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildList(List notifications, bool isLoading, bool isUnread) {
    if (isLoading) {
      return Skeletonizer(
        enabled: true,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: ListTile(
                leading: const CircleAvatar(),
                title: const Text('Skeleton Title here'),
                subtitle: const Text('Skeleton body message goes here...'),
              ),
            );
          },
        ),
      );
    }

    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/empty_state.json',
              width: 200.w,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.notifications_none,
                size: 80.sp,
                color: AppColors.grey,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              isUnread ? 'No unread notifications' : 'No read notifications',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NotificationCard(notification: notifications[index]);
      },
    );
  }
}
