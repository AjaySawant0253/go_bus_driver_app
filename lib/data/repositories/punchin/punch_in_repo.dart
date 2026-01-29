import 'package:go_bus_driver_app/data/models/punchin/trip_punchin_reponse_model.dart';
import 'package:go_bus_driver_app/data/models/punchin/trip_punchin_request_model.dart';

abstract class TripStatusRepository {
  Future<TripStatusResponse> updateTripStatus(
    TripStatusRequest request,
  );
}
