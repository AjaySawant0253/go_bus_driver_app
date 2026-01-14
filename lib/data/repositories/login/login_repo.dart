import 'package:go_bus_driver_app/data/models/login/login_request_model.dart';
import 'package:go_bus_driver_app/data/models/login/login_response_model.dart';

abstract class LoginRepository {
  Future<LoginResponse> login(LoginRequest request);
}
