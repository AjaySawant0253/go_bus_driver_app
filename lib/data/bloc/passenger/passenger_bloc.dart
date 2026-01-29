import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/data/repositories/passenger/passenger_repo.dart';
import 'passenger_event.dart';
import 'passenger_state.dart';

class PassengerBloc extends Bloc<PassengerEvent, PassengerState> {
  final PassengerRepository repository;

  PassengerBloc(this.repository) : super(PassengerInitial()) {
    on<FetchPassengersEvent>(_onFetchPassengers);
    on<ConfirmBoardingEvent>(_onConfirmBoarding);
  }

  Future<void> _onFetchPassengers(
    FetchPassengersEvent event,
    Emitter<PassengerState> emit,
  ) async {
    emit(PassengerLoading());

    try {
      final response = await repository.fetchPassengers(
        tripId: event.tripId,
        pickupId: event.pickupId,
      );

      emit(PassengerLoaded(response));
    } catch (e) {
      emit(PassengerError(e.toString()));
    }
  }

  Future<void> _onConfirmBoarding(
    ConfirmBoardingEvent event,
    Emitter<PassengerState> emit,
  ) async {
    emit(PassengerBoardingLoading());

    try {
      final response = await repository.confirmBoarding(
        boardedId: event.boardedId,
      );

      if (response.status) {
        emit(PassengerBoardingSuccess("Boarding Confirmed"));

      } else {
        emit(PassengerBoardingError("Boarding failed"));
      }
    } catch (e) {
      emit(PassengerBoardingError(e.toString()));
    }
  }
}
