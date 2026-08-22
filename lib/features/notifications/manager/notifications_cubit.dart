import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentora/features/notifications/data/repos/notifications_repo.dart';
import 'package:rentora/features/notifications/manager/notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepo _repo;
  StreamSubscription? _notificationsSubscription;

  NotificationsCubit(this._repo) : super(NotificationsInitial()) {
    getNotifications();
  }

  void getNotifications() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(const NotificationsError('User not authenticated'));
      return;
    }

    emit(NotificationsLoading());

    _notificationsSubscription?.cancel();
    _notificationsSubscription = _repo
        .getNotificationsStream(user.uid)
        .listen(
          (notifications) {
            final unread = notifications.where((n) => !n.isRead).toList();
            final read = notifications.where((n) => n.isRead).toList();

            emit(
              NotificationsLoaded(
                unreadNotifications: unread,
                readNotifications: read,
              ),
            );
          },
          onError: (error) {
            emit(NotificationsError('Failed to load notifications: $error'));
          },
        );
  }

  Future<void> markAsRead(String notificationId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await _repo.markAsRead(user.uid, notificationId);
      // State updates automatically via stream subscription
    } catch (e) {
      // Handle error gracefully if needed, stream will remain active
    }
  }

  @override
  Future<void> close() {
    _notificationsSubscription?.cancel();
    return super.close();
  }
}
