import 'package:flutter/material.dart';

class PunchScreen extends StatelessWidget {
  const PunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Punch In / Punch Out")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Punch In Time: 7:05 AM"),
            const Text("Status: Pending"),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text("Punch In")),
            ElevatedButton(onPressed: () {}, child: const Text("Punch Out")),
          ],
        ),
      ),
    );
  }
}
