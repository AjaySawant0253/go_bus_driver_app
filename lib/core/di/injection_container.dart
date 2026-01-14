import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_bus_driver_app/core/network/api_client.dart';
import 'package:go_bus_driver_app/core/network/network_checker.dart';
import 'package:go_bus_driver_app/core/secure/secure_storage_service.dart';
import 'package:go_bus_driver_app/data/bloc/login/login_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_bloc.dart';
import 'package:go_bus_driver_app/data/repositories/login/login_repo.dart';
import 'package:go_bus_driver_app/data/repositories/login/login_repo_impl.dart';
import 'package:go_bus_driver_app/data/repositories/trip/trip_repo.dart';
import 'package:go_bus_driver_app/data/repositories/trip/trip_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// ✅ External
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );
  sl.registerLazySingleton<NetworkChecker>(() => NetworkChecker());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      sl<Dio>(),
      sl<NetworkChecker>(),
      sl<SecureStorageService>(),
    ),
  );

  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl<ApiClient>()),
  );

  sl.registerFactory<LoginBloc>(
    () => LoginBloc(sl<LoginRepository>()),
  );

sl.registerLazySingleton<TripRepository>(
  () => TripRepositoryImpl(sl<ApiClient>()),
);

sl.registerFactory<TripBloc>(
  () => TripBloc(sl<TripRepository>()),
);
}
