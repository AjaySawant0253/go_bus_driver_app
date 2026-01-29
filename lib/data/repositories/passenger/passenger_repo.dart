import 'package:go_bus_driver_app/data/models/passenger/confirm_onboarding_response.dart';
import 'package:go_bus_driver_app/data/models/passenger/passenger_response.dart';

abstract class PassengerRepository {
  Future<PassengerResponse> fetchPassengers({
    required String tripId,
    required String pickupId,
  });

  Future<ConfirmBoardingResponse> confirmBoarding({
    required String boardedId,
  });
}
