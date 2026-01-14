import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/core/secure/secure_storage_service.dart';
import 'package:go_bus_driver_app/data/bloc/login/login_event.dart';
import 'package:go_bus_driver_app/data/bloc/login/login_state.dart';
import 'package:go_bus_driver_app/data/models/login/login_request_model.dart';
import 'package:go_bus_driver_app/data/repositories/login/login_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final SecureStorageService _storageService = SecureStorageService();

  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginPressed);
  }

  Future<void> _onLoginPressed(
  LoginButtonPressed event,
  Emitter<LoginState> emit,
) async {
  emit(LoginLoading());

  try {
    final response = await loginRepository.login(
      LoginRequest(
        userDetails: event.userDetails,
        password: event.password,
        fcmToken: event.fcmToken,
        signatureId: event.signatureId,
        lat: event.lat,
        lng: event.lng,
      ),
    );

    _storageService.saveToken(response.token);

    emit(LoginSuccess(response.token));
  } catch (e) {
    emit(LoginFailure(e.toString()));
  }
}


  }
