import 'package:go_bus_driver_app/core/constants/api_endpoints.dart';
import 'package:go_bus_driver_app/core/network/api_client.dart';
import 'package:go_bus_driver_app/data/models/route-response/trip_route_response_model.dart';
import 'package:go_bus_driver_app/data/repositories/trip-route-repo/trip_route_repository_repo.dart';

class TripRoutesRepositoryImpl implements TripRoutesRepository {
  final ApiClient apiClient;

  TripRoutesRepositoryImpl(this.apiClient);

  @override
  Future<TripRoutesResponse> fetchTripRoutes(String tripId) async {
    final response = await apiClient.get(
      '${ApiEndpoints.tripRoutes}/$tripId',
      isAuthRequired: true
    );

    if (response.statusCode == 200 && response.data != null) {
      return TripRoutesResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch trip routes');
    }
  }
}
