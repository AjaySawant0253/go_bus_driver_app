class LoginResponse {
  final bool status;
  final String message;
  final String token;
  final UserData? data;

  LoginResponse({
    required this.status,
    required this.message,
    required this.token,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      data: json['data'] != null
          ? UserData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'token': token,
      'data': data?.toJson(),
    };
  }
}

class UserData {
  final String fullName;
  final String gender;
  final String email;
  final String contactNumber;
  final String employeeImage;

  UserData({
    required this.fullName,
    required this.gender,
    required this.email,
    required this.contactNumber,
    required this.employeeImage,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      fullName: json['full_name'] ?? '',
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      employeeImage: json['employee_image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'gender': gender,
      'email': email,
      'contact_number': contactNumber,
      'employee_image': employeeImage,
    };
  }
}
