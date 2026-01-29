import 'package:go_bus_driver_app/data/models/logout/logout_response_model.dart';

abstract class LogoutRepository {
  Future<LogoutResponse> logout();
}
