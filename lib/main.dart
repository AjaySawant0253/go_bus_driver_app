import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/routes/app_router.dart';

void main() {
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
