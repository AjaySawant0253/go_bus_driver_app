import 'package:go_bus_driver_app/core/constants/api_endpoints.dart';
import 'package:go_bus_driver_app/core/network/api_client.dart';
import 'package:go_bus_driver_app/data/models/passenger/confirm_onboarding_response.dart';
import 'package:go_bus_driver_app/data/models/passenger/passenger_response.dart';
import 'package:go_bus_driver_app/data/repositories/passenger/passenger_repo.dart';

class PassengerRepositoryImpl implements PassengerRepository {
  final ApiClient apiClient;

  PassengerRepositoryImpl(this.apiClient);

  @override
  Future<PassengerResponse> fetchPassengers({
    required String tripId,
    required String pickupId,
  }) async {
    final response = await apiClient.get(
      '${ApiEndpoints.tripPickupPassengers}/$tripId/$pickupId',
      isAuthRequired: true
    );

    if (response.statusCode == 200 && response.data != null) {
      return PassengerResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch passengers');
    }
  }

   @override
  Future<ConfirmBoardingResponse> confirmBoarding({
    required String boardedId,
  }) async {
    final response = await apiClient.get(
      '${ApiEndpoints.confirmBoarding}/$boardedId',
      isAuthRequired: true,
    );

    if (response.statusCode == 200 && response.data != null) {
      return ConfirmBoardingResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to confirm boarding');
    }
  }
}
