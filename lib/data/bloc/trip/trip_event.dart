import 'package:equatable/equatable.dart';
import 'package:go_bus_driver_app/data/models/punchin/trip_punchin_request_model.dart';

abstract class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object?> get props => [];
}

class FetchDriverTrips extends TripEvent {}

class SubmitTripStatus extends TripEvent {
  final TripStatusRequest request;

  const SubmitTripStatus(this.request);

  @override
  List<Object?> get props => [request];
}