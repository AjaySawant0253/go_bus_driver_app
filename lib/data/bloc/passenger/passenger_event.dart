abstract class PassengerEvent {}

class FetchPassengersEvent extends PassengerEvent {
  final String tripId;
  final String pickupId;

  FetchPassengersEvent({
    required this.tripId,
    required this.pickupId,
  });
}

class ConfirmBoardingEvent extends PassengerEvent {
  final String boardedId;

  ConfirmBoardingEvent({required this.boardedId});
}
