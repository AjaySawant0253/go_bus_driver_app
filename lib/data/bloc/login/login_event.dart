

import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String userDetails;
  final String password;
  final String fcmToken;
  final String signatureId;
  final String lat;
  final String lng;

  const LoginButtonPressed({
    required this.userDetails,
    required this.password,
    required this.fcmToken,
    required this.signatureId,
    required this.lat,
    required this.lng,
  });

  @override
  List<Object?> get props =>
      [userDetails, password, fcmToken, signatureId, lat, lng];
}
