import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScheduleDetailsScreen extends StatelessWidget {
  const ScheduleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Schedule Details")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Mumbai → Nashik", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("SCHEDULE DATE: 6 October 2025"),
            const Text("BUS NAME: Vighnhar MH47J1234"),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () => context.go("/route"),
              child: const Text("Route Details"),
            ),

            ElevatedButton(
              onPressed: () => context.go("/punch"),
              child: const Text("Punch In"),
            ),
          ],
        ),
      ),
    );
  }
}
