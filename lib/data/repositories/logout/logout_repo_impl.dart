import 'package:go_bus_driver_app/core/constants/api_endpoints.dart';
import 'package:go_bus_driver_app/core/network/api_client.dart';
import 'package:go_bus_driver_app/data/models/logout/logout_response_model.dart';
import 'package:go_bus_driver_app/data/repositories/logout/logout_rep.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final ApiClient apiClient;

  LogoutRepositoryImpl(this.apiClient);

  @override
  Future<LogoutResponse> logout() async {
    final response = await apiClient.post(
      ApiEndpoints.logout,
      isAuthRequired: true,
    );

      return LogoutResponse.fromJson(response.data);
      
  }
}
