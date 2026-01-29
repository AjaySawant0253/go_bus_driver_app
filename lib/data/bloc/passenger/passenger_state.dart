

import 'package:go_bus_driver_app/data/models/passenger/passenger_response.dart';

abstract class PassengerState {}

class PassengerInitial extends PassengerState {}

class PassengerLoading extends PassengerState {}

class PassengerLoaded extends PassengerState {
  final PassengerResponse passengers;

  PassengerLoaded(this.passengers);
}

class PassengerError extends PassengerState {
  final String message;

  PassengerError(this.message);
}

class PassengerBoardingLoading extends PassengerState {}

class PassengerBoardingSuccess extends PassengerState {
  final String message;
  PassengerBoardingSuccess(this.message);
}

class PassengerBoardingError extends PassengerState {
  final String message;
  PassengerBoardingError(this.message);
}

