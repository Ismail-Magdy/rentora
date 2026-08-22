import 'package:rentora/features/notifications/data/models/notification_model.dart';

abstract class NotificationsRepo {
  Stream<List<NotificationModel>> getNotificationsStream(String userId);
  Future<void> markAsRead(String userId, String notificationId);
}
