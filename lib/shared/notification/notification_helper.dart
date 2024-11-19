// shared/notification/notification_helper.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static bool _isInitialized = false;

  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          NotificationNavigator.handleNotificationPayload(response.payload!);
        }
      },
    );

    _isInitialized = true; //  initialized
  }

  /// Shows a notification
  static Future<void> showNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    if (!_isInitialized) {
      throw Exception("Notification plugin is not initialized. Call initializeNotifications first.");
    }

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'main_channel', 
      'Main Channel', 
      channelDescription: 'This is the main channel for notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformDetails,
      payload: payload,
    );
  }
}

class NotificationNavigator {
  static void handleNotificationPayload(String payload) {
    if (payload == 'patient_profile') {
      
    } else if (payload == 'doctor_profile') {
      
    }
  }
}
