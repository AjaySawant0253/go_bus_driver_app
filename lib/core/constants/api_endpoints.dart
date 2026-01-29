import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  // 🌐 Base URLs
  static String get baseUrl => 'https://test.newtrimurtitravels.com';
  static String get login => '$baseUrl/api/v1/driver/login';
  static String get getTrips => '$baseUrl/api/v1/driver/trip';
  static String get punchInOut => '$baseUrl/api/v1/driver/change-trip-status';
  static String get tripRoutes => '$baseUrl/api/v1/driver/trip-routes';
  static String get tripPickupPassengers =>
      '/api/v1/driver/trip-pickup-passenger';
  static String get confirmBoarding => '/api/v1/driver/passenger-boarded';
  static String get logout => "/api/v1/driver/logout";
}
