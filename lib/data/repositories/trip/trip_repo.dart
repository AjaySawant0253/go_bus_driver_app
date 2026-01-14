import 'package:go_bus_driver_app/data/models/trip/driver_trip_response_model.dart';

abstract class TripRepository {
  Future<DriverTripsResponse> fetchDriverTrips();
}
