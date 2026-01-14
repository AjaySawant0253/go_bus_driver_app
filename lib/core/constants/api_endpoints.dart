import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  // 🌐 Base URLs
  static String get baseUrl => dotenv.env['BASE_URL']!;
  static String get login => '$baseUrl/api/v1/driver/login';
  static String get resendOtp => '$baseUrl/api/v1/customer/resend';
  static String get verifyOtp => '$baseUrl/api/v1/customer/verify';
  static String get register => '$baseUrl/api/v1/customer/register';
  static String get startFrom => '$baseUrl/api/v1/fetch-start-from';
  static String get endAt => '$baseUrl/api/v1/fetch-end-at';
  static String get fetchAdvertisements => '$baseUrl/api/v1/get-advertisement';
  static String get fetchRoutes => '$baseUrl/api/v1/fetch-routes/';
  static String get fetchTripDetails => '$baseUrl/api/v1/fetch-trip-details';
  static String get fetchTripDetailInfo => '$baseUrl/api/v1/fetch-trip-detail-info';
  static String get storeSeatsBooking => '$baseUrl/api/v1/store-seats-booking';
  static String get confirmBooking => '$baseUrl/api/v1/confirm-booking';
  static String get generateNewOrder => '$baseUrl/api/v1/generate-new-order';
  static String get cancelBooking => '$baseUrl/api/v1/cancel-passenger-booking';
  static String get customerBookingInfo => '$baseUrl/api/v1/customer/booking-info';
  static String get customerProfile => '$baseUrl/api/v1/customer/profile';
  static String get updateCustomerProfile => '$baseUrl/api/v1/customer/profile/update';
  static String get logoutCustomer => '$baseUrl/api/v1/customer/logout';
  static String get fetchSavedPassenger => '$baseUrl/api/v1/customer/passengers';
  static String get cancelBookingCalculate => '$baseUrl/api/v1/cancel-booking/calculate';
  static String get fetchRoutesInfo => '$baseUrl/api/v1/customer/route-detail';
}
