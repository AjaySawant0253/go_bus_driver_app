import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/core/di/injection_container.dart';
import 'package:go_bus_driver_app/core/network/api_client.dart';
import 'package:go_bus_driver_app/data/bloc/login/login_bloc.dart';
import 'package:go_bus_driver_app/data/repositories/login/login_repo_impl.dart';
import 'package:go_bus_driver_app/routes/route_paths.dart';
import 'package:go_bus_driver_app/screens/home/home_screen.dart';
import 'package:go_bus_driver_app/screens/login/login.dart';
import 'package:go_bus_driver_app/screens/passengers/passenger_detail_screen.dart';
import 'package:go_bus_driver_app/screens/passengers/passenger_list_screen.dart';
import 'package:go_bus_driver_app/screens/routes/pick_up_drop_screen.dart';
import 'package:go_bus_driver_app/screens/routes/punch_screen.dart';
import 'package:go_bus_driver_app/screens/routes/route_details_screen.dart';
import 'package:go_bus_driver_app/screens/schedule/schedule_details_screen.dart';
import 'package:go_bus_driver_app/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.splashScreen,
  routes: [
    GoRoute(path: RoutePaths.splashScreen, builder: (context, state) => SplashScreen()),
    GoRoute(
      path: RoutePaths.login,
      name: RoutePaths.login,
      builder: (context, state) {
        return BlocProvider<LoginBloc>(
          create: (_) => sl<LoginBloc>(),
          child: LoginScreen(),
        );
      },
    ),

    GoRoute(path: RoutePaths.home,name: RoutePaths.home, builder: (_, __) => const HomeScreen()),
    GoRoute(path: RoutePaths.schedule,name: RoutePaths.schedule, builder: (_, __) => const ScheduleDetailsScreen()),
    GoRoute(path: RoutePaths.route, builder: (_, __) => const RouteDetailsScreen()),
    GoRoute(path: RoutePaths.punch, builder: (_, __) => const PunchScreen()),
    GoRoute(path: RoutePaths.pickups, builder: (_, __) => const PickupDropScreen()),
    GoRoute(path: RoutePaths.passengers, builder: (_, __) => const PassengerListScreen()),
    GoRoute(path: RoutePaths.passDetails, builder: (_, __) => const PassengerDetailsScreen()),
  ],
);
