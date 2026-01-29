import 'package:go_bus_driver_app/data/models/punchin/trip_punchin_reponse_model.dart';
import 'package:go_bus_driver_app/data/models/punchin/trip_punchin_request_model.dart';
import 'package:go_bus_driver_app/data/models/trip/driver_trip_response_model.dart';

abstract class TripRepository {
  Future<DriverTripsResponse> fetchDriverTrips();
  Future<TripStatusResponse> punchTripStatus(TripStatusRequest request);
}
