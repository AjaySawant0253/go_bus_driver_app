import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_bus_driver_app/core/di/injection_container.dart';
import 'package:go_bus_driver_app/routes/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await dotenv.load(fileName: 'assets/env/.env.dev');
  runApp(const GoBusDriverApp());
}

class GoBusDriverApp extends StatelessWidget {
  const GoBusDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "GoBus Driver",
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
