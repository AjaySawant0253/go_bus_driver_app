import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/data/repositories/logout/logout_rep.dart';
import 'logout_event.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutRepository logoutRepository;

  LogoutBloc(this.logoutRepository) : super(LogoutInitial()) {
    on<LogoutRequested>((event, emit) async {
      emit(LogoutLoading());

      try {
        final response = await logoutRepository.logout();
        emit(LogoutSuccess(response.message));
      } catch (e) {
        emit(LogoutFailure(e.toString()));
      }
    });
  }
}
