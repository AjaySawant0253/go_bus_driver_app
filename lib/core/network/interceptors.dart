import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_bus_driver_app/core/secure/secure_storage_service.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/route_paths.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppInterceptors extends Interceptor {
  final SecureStorageService _storageService = SecureStorageService();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      dynamic data = response.data;

      if (kIsWeb && data is String) {
        data = jsonDecode(data);
      }

      if (data is Map<String, dynamic> && data['token'] != null ||
          data is Map<String, dynamic> && data['new_token'] != null) {
        final token = data['token'];
        final newToken = data['new_token'];
        if (token is String && token.isNotEmpty) {
          await _storageService.saveToken(token);
        }
        if (newToken is String && newToken.isNotEmpty) {
          await _storageService.saveToken(newToken);
        }
      }
    } catch (_) {
      if (kDebugMode) {
        print('');
      }
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response?.statusCode == 422) {
        dynamic data = err.response?.data;

        if (kIsWeb && data is String) {
          data = jsonDecode(data);
        }

        if (data is Map<String, dynamic>) {
          if (data['token'] != null) {
            final token = data['token'];

            if (token is String && token.isNotEmpty) {
              await _storageService.saveToken(token);
            }
          }
        }
      }
    } catch (_) {
      if (kDebugMode) {
        print("Failed to save token from error response:");
      }
    }

    if (err.response?.statusCode == 401) {
      final storageService = SecureStorageService();
      await storageService.clear();
      final context = appNavigatorKey.currentContext;

      if (context != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(RoutePaths.login);
        });
      }
    }
    if (err.response?.statusCode == 503) {
      final context = appNavigatorKey.currentContext;
      if (context != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(RoutePaths.login);
        });
      }
    }
    // if (err.response?.statusCode == 401 ||
    //     err.type == DioExceptionType.unknown) {
    //   await forceLogout();
    // }
    super.onError(err, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await _storageService.getToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      options.headers['Accept'] = 'application/json';
      if (options.data is! FormData) {
        options.headers['Content-Type'] = 'application/json';
      }
    } catch (e) {
      if (kDebugMode) print('Failed to attach token: $e');
    }

    return super.onRequest(options, handler);
  }

  Future<void> forceLogout() async {
    try {
      await _storageService.clear();
      final context = appNavigatorKey.currentContext;
      if (context != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(RoutePaths.login);
        });
      }
    } catch (e) {
      if (kDebugMode) print('Logout failed: $e');
    }
  }
}
