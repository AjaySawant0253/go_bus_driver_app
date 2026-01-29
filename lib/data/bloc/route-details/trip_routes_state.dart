import 'package:go_bus_driver_app/data/models/route-response/trip_route_response_model.dart';

abstract class TripRoutesState {}

class TripRoutesInitial extends TripRoutesState {}

class TripRoutesLoading extends TripRoutesState {}

class TripRoutesLoaded extends TripRoutesState {
  final TripRoutesResponse response;

  TripRoutesLoaded(this.response);
}

class TripRoutesError extends TripRoutesState {
  final String message;

  TripRoutesError(this.message);
}
