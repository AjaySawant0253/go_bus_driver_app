class TripStatusResponse {
  final bool status;
  final String message;

  TripStatusResponse({
    required this.status,
    required this.message,
  });

  factory TripStatusResponse.fromJson(Map<String, dynamic> json) {
    return TripStatusResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
