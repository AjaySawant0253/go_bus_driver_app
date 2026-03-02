import 'dart:async';
import 'dart:convert';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:go_bus_driver_app/core/constants/api_endpoints.dart';

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false, // ✅ IMPORTANT (Do not auto start)
      isForegroundMode: true,
      foregroundServiceNotificationId: 1001,
      initialNotificationTitle: "Go Bus Tracking",
      initialNotificationContent: "Tracking not started",
    ),
    iosConfiguration: IosConfiguration(),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "Go Bus Tracking",
      content: "Waiting for punch-in...",
    );
  }

  Timer? timer;
  String? token;
  String? tripId;

  // ✅ Start tracking ONLY when punch-in event comes
  service.on("startTracking").listen((event) {
    token = event?["token"];
    tripId = event?["tripId"];

    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Go Bus Tracking",
        content: "Tracking driver location...",
      );
    }

    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 30), (_) async {
      if (token == null || tripId == null) return;

      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        final body = {
          "trip_id": tripId,
          "lat": position.latitude,
          "lng": position.longitude,
        };

        final response = await http.post(
          Uri.parse(ApiEndpoints.updateLocation),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(body),
        );

        print("📍 Background Sent: $body");
        print("✅ Status: ${response.statusCode}");
      } catch (e) {
        print("❌ Background Error: $e");
      }
    });
  });

  // ✅ Stop tracking
  service.on("stopTracking").listen((event) {
    timer?.cancel();
    service.stopSelf();
  });
}