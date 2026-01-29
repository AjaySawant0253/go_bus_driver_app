import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_bus_driver_app/core/di/injection_container.dart';
import 'package:go_bus_driver_app/core/firebase/Firebase_messaging.dart';
import 'package:go_bus_driver_app/core/firebase/notification_service.dart';
import 'package:go_bus_driver_app/routes/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessagingService.init();
  await NotificationService.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await init();
  await dotenv.load(fileName: 'assets/env/.env.prod');
  runApp(const GoBusDriverApp());
}

class GoBusDriverApp extends StatelessWidget {
  const GoBusDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Trimurti Travels Driver",
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
