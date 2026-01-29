import 'package:go_bus_driver_app/core/constants/api_endpoints.dart';
import 'package:go_bus_driver_app/core/network/api_client.dart';
import 'package:go_bus_driver_app/data/models/punchin/trip_punchin_reponse_model.dart';
import 'package:go_bus_driver_app/data/models/punchin/trip_punchin_request_model.dart';
import 'package:go_bus_driver_app/data/repositories/punchin/punch_in_repo.dart';

class TripStatusRepositoryImpl implements TripStatusRepository {
  final ApiClient apiClient;

  TripStatusRepositoryImpl(this.apiClient);

  @override
  Future<TripStatusResponse> updateTripStatus(
    TripStatusRequest request,
  ) async {
    final response = await apiClient.post(
      ApiEndpoints.punchInOut,
      data: request.toJson(),
    );

    if (response.statusCode == 200 && response.data != null) {
      return TripStatusResponse.fromJson(response.data);
    } else {
      throw Exception('Trip status update failed');
    }
  }
}
