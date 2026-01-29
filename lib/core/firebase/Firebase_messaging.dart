import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_bus_driver_app/core/firebase/notification_service.dart';
import 'package:go_bus_driver_app/core/secure/secure_storage_service.dart';

class FirebaseMessagingService {
  static Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final SecureStorageService _storageService = SecureStorageService();

    // Permission (Android 13+ & iOS)
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get FCM token
    String? token = await messaging.getToken();
    print('FCM Token: $token');

    if (token is String && token.isNotEmpty) {
          await _storageService.saveFcmToken(token);
    }


    // 🔔 FOREGROUND messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        NotificationService.show(
          title: message.notification!.title ?? 'New Notification',
          body: message.notification!.body ?? '',
        );
      }
    });

    // 🔁 App opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //debugPrint('Notification clicked!');
    });
  }
}
