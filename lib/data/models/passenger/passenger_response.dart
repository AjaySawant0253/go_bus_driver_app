class PassengerResponse {
  final bool status;
  final String message;
  final List<Passenger> data;

  PassengerResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PassengerResponse.fromJson(Map<String, dynamic> json) {
    return PassengerResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => Passenger.fromJson(e))
          .toList(),
    );
  }
}
class Passenger {
  final String bookingId;
  final String boardedId;
  final String seatNumber;
  final String boardedStatus;
  final String passengerName;
  final String gender;
  final String age;
  final String healthIssue;
  final String contactNumber;
  final String infant;

  Passenger({
    required this.bookingId,
    required this.boardedId,
    required this.seatNumber,
    required this.boardedStatus,
    required this.passengerName,
    required this.gender,
    required this.age,
    required this.healthIssue,
    required this.contactNumber,
    required this.infant,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      bookingId: json['booking_id'] ?? '',
      boardedId: json['boarded_id'] ?? '',
      seatNumber: json['seat_number'] ?? '',
      boardedStatus: json['boarded_status'] ?? '',
      passengerName: json['passenger_name'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] ?? '0',
      healthIssue: json['health_issue'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      infant: json['infant'] ?? '',
    );
  }
}
