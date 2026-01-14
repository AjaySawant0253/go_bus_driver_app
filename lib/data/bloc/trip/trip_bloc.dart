import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_event.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_state.dart';
import 'package:go_bus_driver_app/data/repositories/trip/trip_repo.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository repository;

  TripBloc(this.repository) : super(TripInitial()) {
    on<FetchDriverTrips>(_onFetchTrips);
  }

  Future<void> _onFetchTrips(
    FetchDriverTrips event,
    Emitter<TripState> emit,
  ) async {
    emit(TripLoading());

    try {
      final response = await repository.fetchDriverTrips();
      emit(TripLoaded(response));
    } catch (e) {
      emit(TripError(e.toString()));
    }
  }
}
