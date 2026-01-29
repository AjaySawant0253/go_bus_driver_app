import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_bus_driver_app/core/network/api_client.dart';
import 'package:go_bus_driver_app/core/network/network_checker.dart';
import 'package:go_bus_driver_app/core/secure/secure_storage_service.dart';
import 'package:go_bus_driver_app/data/bloc/login/login_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/logout/logout_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/passenger/passenger_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/route-details/trip_routes_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_bloc.dart';
import 'package:go_bus_driver_app/data/repositories/login/login_repo.dart';
import 'package:go_bus_driver_app/data/repositories/login/login_repo_impl.dart';
import 'package:go_bus_driver_app/data/repositories/logout/logout_rep.dart';
import 'package:go_bus_driver_app/data/repositories/logout/logout_repo_impl.dart';
import 'package:go_bus_driver_app/data/repositories/passenger/passenger_repo.dart';
import 'package:go_bus_driver_app/data/repositories/passenger/passenger_repo_impl.dart';
import 'package:go_bus_driver_app/data/repositories/trip-route-repo/trip_route_repository_impl.dart';
import 'package:go_bus_driver_app/data/repositories/trip-route-repo/trip_route_repository_repo.dart';
import 'package:go_bus_driver_app/data/repositories/trip/trip_repo.dart';
import 'package:go_bus_driver_app/data/repositories/trip/trip_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// ✅ External
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<NetworkChecker>(() => NetworkChecker());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerLazySingleton<ApiClient>(
    () =>
        ApiClient(sl<Dio>(), sl<NetworkChecker>(), sl<SecureStorageService>()),
  );

  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl<ApiClient>()),
  );

  sl.registerFactory<LoginBloc>(() => LoginBloc(sl<LoginRepository>()));

  sl.registerLazySingleton<TripRepository>(
    () => TripRepositoryImpl(sl<ApiClient>()),
  );

  sl.registerFactory<TripBloc>(() => TripBloc(sl<TripRepository>()));

  sl.registerLazySingleton<TripRoutesRepository>(
    () => TripRoutesRepositoryImpl(sl<ApiClient>()),
  );

  sl.registerFactory<TripRoutesBloc>(
    () => TripRoutesBloc(sl<TripRoutesRepository>()),
  );

  sl.registerLazySingleton<PassengerRepository>(
    () => PassengerRepositoryImpl(sl<ApiClient>()),
  );

  sl.registerFactory<PassengerBloc>(
    () => PassengerBloc(sl<PassengerRepository>()),
  );

  sl.registerLazySingleton<LogoutRepository>(
    () => LogoutRepositoryImpl(sl<ApiClient>()),
  );

  sl.registerFactory<LogoutBloc>(
    () => LogoutBloc(sl<LogoutRepository>()),
  );
}
