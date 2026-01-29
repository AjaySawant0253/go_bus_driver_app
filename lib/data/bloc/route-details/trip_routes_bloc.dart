import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/route-details/trip_routes_event.dart';
import 'package:go_bus_driver_app/data/bloc/route-details/trip_routes_state.dart';
import 'package:go_bus_driver_app/data/repositories/trip-route-repo/trip_route_repository_repo.dart';

class TripRoutesBloc extends Bloc<TripRoutesEvent, TripRoutesState> {
  final TripRoutesRepository repository;

  TripRoutesBloc(this.repository) : super(TripRoutesInitial()) {
    on<FetchTripRoutes>(_onFetchTripRoutes);
  }

  Future<void> _onFetchTripRoutes(
    FetchTripRoutes event,
    Emitter<TripRoutesState> emit,
  ) async {
    emit(TripRoutesLoading());

    try {
      final response = await repository.fetchTripRoutes(event.tripId);
      emit(TripRoutesLoaded(response));
    } catch (e) {
      emit(TripRoutesError(e.toString()));
    }
  }
}
