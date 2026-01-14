import 'package:dio/dio.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';

class AppExceptions implements Exception {
  final String message;
  final String prefix;

  AppExceptions([this.message = "Something went wrong", this.prefix = "Error"]);

  @override
  String toString() => message;

  static AppExceptions fromDioError(DioException error) {
    final statusCode = error.response?.statusCode ?? 0;
    dynamic data = error.response?.data;

    if (data is String) {
      try {
        data = jsonDecode(data);
      } catch (_) {
        if (kDebugMode) {
          print("⚠️ Could not decode JSON: $data");
        }
        data = null;
      }
    }

    String serverMessage = 'Unexpected error';
    if (data is Map && data.containsKey('message')) {
      serverMessage = data['message'].toString();
    }

    if (kDebugMode) {
      print("❌ DioException caught:");
      print("🔹 Type: ${error.type}");
      print("🔹 StatusCode: $statusCode");
      print("🔹 Message: $serverMessage");
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return RequestTimeOut('Connection timed out');

      case DioExceptionType.badResponse:
        if (statusCode == 422) {
          if (data is Map &&
              data.containsKey('status') &&
              data['status'] == 'error') {
            return ApiErrorException(serverMessage);
          }
          return NotFoundException(serverMessage);
        }

        if (statusCode == 401) return UnAuthorizedException(serverMessage);
        if (statusCode == 404) return NotFoundException(serverMessage);
        if (statusCode >= 422) return ProfilePicException(serverMessage);
        if (statusCode >= 500) return ServerException(serverMessage);
        if (statusCode >= 503) return MaintenanceException(serverMessage);
        return FetchDataException(serverMessage);

      case DioExceptionType.connectionError:
        return InternetException('No Internet Connection');

      case DioExceptionType.cancel:
        return AppExceptions('Request Cancelled', 'Cancelled');

      case DioExceptionType.unknown:
      default:
        return AppExceptions(error.message ?? 'Unknown Error');
    }
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message])
      : super(message ?? 'No internet connection', 'Network Error');
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message])
      : super(message ?? 'Request timed out', 'Timeout Error');
}

class ServerException extends AppExceptions {
  ServerException([String? message])
      : super(message ?? 'Server Error', 'Server Error');
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message])
      : super(message ?? 'Invalid URL', 'URL Error');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message ?? 'Error fetching data', 'Data Error');
}

class NotFoundException extends AppExceptions {
  NotFoundException([String message = 'Resource Not Found'])
      : super(message, '');
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String message = 'Unauthorized Request'])
      : super(message, '🔒 Unauthorized');
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String message = 'Invalid Input'])
      : super(message, '📝 Invalid Input');
}

class ApiErrorException extends AppExceptions {
  ApiErrorException([String message = 'Unexpected API error'])
      : super(message, '⚠️ API Error');
}

class MaintenanceException extends AppExceptions {
  MaintenanceException([String message = 'Server is under maintenance'])
      : super(message, '🛠️ Maintenance');
}

class ProfilePicException extends AppExceptions {
  ProfilePicException([String message = 'The profile pic field to upload'])
      : super(message, '');
}
