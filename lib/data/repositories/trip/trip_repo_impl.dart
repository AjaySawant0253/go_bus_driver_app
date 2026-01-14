import 'package:go_bus_driver_app/core/constants/api_endpoints.dart';
import 'package:go_bus_driver_app/core/network/api_client.dart';
import 'package:go_bus_driver_app/data/models/trip/driver_trip_response_model.dart';
import 'package:go_bus_driver_app/data/repositories/trip/trip_repo.dart';

class TripRepositoryImpl implements TripRepository {
  final ApiClient apiClient;

  TripRepositoryImpl(this.apiClient);

  @override
  Future<DriverTripsResponse> fetchDriverTrips() async {
    final response = await apiClient.get(ApiEndpoints.getTrips,isAuthRequired: true);

    return DriverTripsResponse.fromJson(response.data);
  }
}
