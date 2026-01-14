import 'package:go_bus_driver_app/core/constants/api_endpoints.dart';
import 'package:go_bus_driver_app/core/network/api_client.dart';
import 'package:go_bus_driver_app/data/models/login/login_request_model.dart';
import 'package:go_bus_driver_app/data/models/login/login_response_model.dart';
import 'package:go_bus_driver_app/data/repositories/login/login_repo.dart';

class LoginRepositoryImpl implements LoginRepository {
  final ApiClient apiClient;

  LoginRepositoryImpl(this.apiClient);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await apiClient.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );

    if (response.statusCode == 200 && response.data != null) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception('Login failed');
    }
  }
}
