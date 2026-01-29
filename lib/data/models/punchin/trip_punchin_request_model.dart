class TripStatusRequest {
  final String tripId;
  final String status;

  TripStatusRequest({
    required this.tripId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "trip_id": tripId,
      "status": status,
    };
  }
}
