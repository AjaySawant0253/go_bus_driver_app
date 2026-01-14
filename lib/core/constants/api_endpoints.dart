import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  // 🌐 Base URLs
  static String get baseUrl => dotenv.env['BASE_URL']!;
  static String get login => '$baseUrl/api/v1/driver/login';
  static String get getTrips => '$baseUrl/api/v1/driver/trip';
}
