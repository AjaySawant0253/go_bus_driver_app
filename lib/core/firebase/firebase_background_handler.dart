

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_bus_driver_app/core/firebase/notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  if (message.notification != null) {
    NotificationService.show(
      title: message.notification!.title ?? 'New Notification',
      body: message.notification!.body ?? '',
    );
  }
}
