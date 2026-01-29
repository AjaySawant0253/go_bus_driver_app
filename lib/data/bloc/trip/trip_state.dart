import 'package:equatable/equatable.dart';
import 'package:go_bus_driver_app/data/models/punchin/trip_punchin_reponse_model.dart';
import 'package:go_bus_driver_app/data/models/trip/driver_trip_response_model.dart';

abstract class TripState extends Equatable {
  const TripState();

  @override
  List<Object?> get props => [];
}

class TripInitial extends TripState {}

class TripLoading extends TripState {}

class TripLoaded extends TripState {
  final DriverTripsResponse response;

  const TripLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class TripError extends TripState {
  final String message;

  const TripError(this.message);

  @override
  List<Object?> get props => [message];
}
/// Initial
class TripStatusInitial extends TripState {}

/// API calling
class TripStatusLoading extends TripState {}

/// Success response
class TripStatusSuccess extends TripState {
  final TripStatusResponse response;

  const TripStatusSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

/// Error state
class TripStatusError extends TripState {
  final String message;

  const TripStatusError(this.message);

  @override
  List<Object?> get props => [message];
}