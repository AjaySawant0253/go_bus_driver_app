class LoginRequest {
  final String userDetails;
  final String password;
  final String fcmToken;
  final String signatureId;
  final String lat;
  final String lng;

  LoginRequest({
    required this.userDetails,
    required this.password,
    required this.fcmToken,
    required this.signatureId,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_details": userDetails,
      "password": password,
      "fcmtoken": fcmToken,
      "signature_id": signatureId,
      "lat": lat,
      "lng": lng,
    };
  }
}
