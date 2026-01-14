import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_bus_driver_app/core/network/api_client.dart';
import 'package:go_bus_driver_app/core/network/network_checker.dart';
import 'package:go_bus_driver_app/core/secure/secure_storage_service.dart';
import 'package:go_bus_driver_app/data/bloc/login/login_bloc.dart';
import 'package:go_bus_driver_app/data/repositories/login/login_repo.dart';
import 'package:go_bus_driver_app/data/repositories/login/login_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';



final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<NetworkChecker>(() => NetworkChecker());

  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(sl<Dio>(), sl<NetworkChecker>(),sl<SecureStorageService>()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  // 🔑 STEP 2: Register it
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl<ApiClient>()),
  );

  // Bloc (use factory!)
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl<LoginRepository>()));

 


}
