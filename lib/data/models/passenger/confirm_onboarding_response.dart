class ConfirmBoardingResponse {
  final bool status;
  final String message;

  ConfirmBoardingResponse({
    required this.status,
    required this.message,
  });

  factory ConfirmBoardingResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmBoardingResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
