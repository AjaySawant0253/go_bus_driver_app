import 'package:go_bus_driver_app/data/models/route-response/trip_route_response_model.dart';

abstract class TripRoutesRepository {
  Future<TripRoutesResponse> fetchTripRoutes(String tripId);
}
