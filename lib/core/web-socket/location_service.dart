import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:go_bus_driver_app/core/constants/api_endpoints.dart';
import 'package:http/http.dart' as http;

class LocationTrackingService {
  static final LocationTrackingService _instance =
      LocationTrackingService._internal();

  factory LocationTrackingService() => _instance;
  LocationTrackingService._internal();

  Timer? _timer;

  String? _token;
  String? _tripId;

  bool _isTracking = false;

  // =========================================================
  // 1️⃣ ASK PERMISSION WHEN APP STARTS
  // =========================================================
  static Future<void> requestInitialPermission() async {
    await _checkServiceEnabled();

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }
  }

  // =========================================================
  // 2️⃣ CHECK AGAIN ON PUNCH IN
  // =========================================================
  static Future<bool> ensureLocationReady() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    // Ask permission if denied
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // If permanently denied
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }

    // 🔥 Request background permission
    if (permission == LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  static Future<void> _checkServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
  }

  // =========================================================
  // 3️⃣ START TRACKING
  // =========================================================
  Future<void> startTracking({
    required String token,
    required String tripId,
  }) async {
    if (_isTracking) {
      print("⚠ Already tracking. Ignoring start request.");
      return;
    }

    bool ready = await ensureLocationReady();
    if (!ready) {
      print("❌ Location not ready");
      return;
    }

    _token = token;
    _tripId = tripId;
    _isTracking = true;

    print("✅ Location tracking started");

    // Send immediately
    await _sendCurrentLocation();

    // Send every 30 seconds
    _timer = Timer.periodic(const Duration(seconds: 30), (_) async {
      if (_isTracking) {
        await _sendCurrentLocation();
      }
    });
  }

  // =========================================================
  // 4️⃣ SEND LOCATION
  // =========================================================
  Future<void> _sendCurrentLocation() async {
    if (!_isTracking || _tripId == null || _token == null) return;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final data = {
        "trip_id": _tripId,
        "lat": position.latitude,
        "lng": position.longitude,
      };

      final response = await http.post(
        Uri.parse(ApiEndpoints.updateLocation),
        headers: {
          "Authorization": "Bearer $_token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(data),
      );

      print("📍 Location sent: $data");
      print("✅ Status: ${response.statusCode}");
    } catch (e) {
      print("❌ Location send error: $e");
    }
  }

  // =========================================================
  // 5️⃣ STOP TRACKING
  // =========================================================
  Future<void> stopTracking() async {
    if (!_isTracking) {
      print("⚠ Tracking already stopped.");
      return;
    }

    _timer?.cancel();
    _timer = null;

    _isTracking = false;
    _tripId = null;
    _token = null;

    print("🛑 Tracking fully stopped");
  }

  // =========================================================
  // 6️⃣ CHECK IF TRACKING ACTIVE
  // =========================================================
  bool get isTracking => _isTracking;
}