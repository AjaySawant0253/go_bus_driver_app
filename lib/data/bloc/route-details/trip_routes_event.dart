abstract class TripRoutesEvent {}

class FetchTripRoutes extends TripRoutesEvent {
  final String tripId;

  FetchTripRoutes(this.tripId);
}
