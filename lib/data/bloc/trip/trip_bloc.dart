import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_event.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_state.dart';
import 'package:go_bus_driver_app/data/models/punchin/trip_punchin_request_model.dart';
import 'package:go_bus_driver_app/data/repositories/trip/trip_repo.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository repository;

  TripBloc(this.repository) : super(TripInitial()) {
    on<FetchDriverTrips>(_onFetchTrips);
    on<SubmitTripStatus>(_punchInTrip);
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

  Future<void> _punchInTrip(
      SubmitTripStatus event, Emitter<TripState> emit) async {
    try {
      final result = await repository.punchTripStatus(
        event.request,
        );

      if (result.status) {
        emit(TripStatusSuccess(result));
        // 🔥 RELOAD TRIPS AFTER SUCCESS
      }
      add(FetchDriverTrips()); 
    } catch (e) {
      emit(TripError(e.toString()));
    }}
    
}
