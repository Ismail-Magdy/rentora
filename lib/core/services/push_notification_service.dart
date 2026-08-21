import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/rentora.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void handleMessage(RemoteMessage message) {
  if (navigatorKey.currentState == null) return;

  final type = message.data['type'];
  final relatedId = message.data['relatedId'];

  if (type == 'chat') {
    navigatorKey.currentState?.pushNamed(
      Routes.chatScreen,
      arguments: relatedId,
    );
  } else if (type == 'booking') {
    navigatorKey.currentState?.pushNamed(Routes.incomingRentalRequestScreen);
  }
}

class PushNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Request permission
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // Initialize local notifications for foreground display
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings();
      const InitializationSettings initializationSettings =
          InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
          );

      await _localNotificationsPlugin.initialize(
        settings: initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          // Handle foreground notification tap
          final payload = response.payload;
          if (payload != null && navigatorKey.currentState != null) {
            // Note: payload only contains the string, we might need a delimiter if passing multiple items.
            // For simplicity we route to notifications screen
            navigatorKey.currentState?.pushNamed(Routes.notificationsScreen);
          }
        },
      );

      // Handle App opened from terminated state
      RemoteMessage? initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();
      if (initialMessage != null) {
        handleMessage(initialMessage);
      }

      // Handle App opened from background state
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Save FCM Token
      await _saveTokenToDatabase();

      // Listen to token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        _updateTokenInDatabase(newToken);
      });

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          _showLocalNotification(message);
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  static Future<void> _saveTokenToDatabase() async {
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      await _updateTokenInDatabase(token);
    }
  }

  static Future<void> _updateTokenInDatabase(String token) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'fcmToken': token},
      );
    }
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'rentora_high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _localNotificationsPlugin.show(
      id: message.notification.hashCode,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: platformChannelSpecifics,
      payload: message.data['type'], // You can pass more data as needed
    );
  }
}
