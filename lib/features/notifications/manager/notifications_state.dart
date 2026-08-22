import 'package:equatable/equatable.dart';
import 'package:rentora/features/notifications/data/models/notification_model.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> unreadNotifications;
  final List<NotificationModel> readNotifications;

  const NotificationsLoaded({
    required this.unreadNotifications,
    required this.readNotifications,
  });

  @override
  List<Object> get props => [unreadNotifications, readNotifications];
}

class NotificationsError extends NotificationsState {
  final String message;

  const NotificationsError(this.message);

  @override
  List<Object> get props => [message];
}
