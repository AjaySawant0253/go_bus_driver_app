import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_bus_driver_app/core/constants/api_endpoints.dart';
import 'package:go_bus_driver_app/core/exceptions/app_exceptions.dart';
import 'package:go_bus_driver_app/core/secure/secure_storage_service.dart';

import '../network/network_checker.dart';

enum HttpMethod { get, post, put, patch, delete }

class ApiClient {
  final Dio dio;
  final NetworkChecker networkChecker;
  final SecureStorageService secureStorage;

  ApiClient(
    this.dio,
    this.networkChecker,
    this.secureStorage,
  ) {
    dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 40),
      receiveTimeout: const Duration(seconds: 40),
      sendTimeout: const Duration(seconds: 20),
      responseType: kIsWeb ? ResponseType.plain : ResponseType.json,
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  // ----------------------------------------------------
  // CORE REQUEST HANDLER
  // ----------------------------------------------------
  Future<Response> _sendRequest({
    required HttpMethod method,
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isAuthRequired = false,
  }) async {
    if (!await networkChecker.isConnected()) {
      throw InternetException();
    }

    // 🔐 ADD TOKEN IF REQUIRED
    if (isAuthRequired) {
      final token = await secureStorage.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      dio.options.headers.remove('Authorization');
    }

    try {
      late Response response;

      switch (method) {
        case HttpMethod.get:
          response = await dio.get(path, queryParameters: queryParameters);
          break;
        case HttpMethod.post:
          response = await dio.post(path, data: data);
          break;
        case HttpMethod.put:
          response = await dio.put(path, data: data);
          break;
        case HttpMethod.patch:
          response = await dio.patch(path, data: data);
          break;
        case HttpMethod.delete:
          response = await dio.delete(path, data: data);
          break;
      }

      dynamic responseData = response.data;

      if (kIsWeb && responseData is String) {
        responseData = jsonDecode(responseData);
      }

      if (response.statusCode == 200 &&
          responseData is Map<String, dynamic> &&
          responseData['status'] == false) {
        throw ApiErrorException(responseData['message']);
      }

      return response;
    } on DioException catch (e) {
      throw AppExceptions.fromDioError(e);
    }
  }

  // ----------------------------------------------------
  // PUBLIC METHODS
  // ----------------------------------------------------
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool isAuthRequired = false,
  }) {
    return _sendRequest(
      method: HttpMethod.get,
      path: path,
      queryParameters: queryParameters,
      isAuthRequired: isAuthRequired,
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    bool isAuthRequired = false,
  }) {
    return _sendRequest(
      method: HttpMethod.post,
      path: path,
      data: data,
      isAuthRequired: isAuthRequired,
    );
  }
}
