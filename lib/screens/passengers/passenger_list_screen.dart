import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PassengerListScreen extends StatelessWidget {
  const PassengerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Passengers")),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return ListTile(
            title: const Text("Ajay Chorge"),
            subtitle: const Text("Seat No: 22"),
            trailing: const Text("Pending"),
            onTap: () => context.go("/passenger-details"),
          );
        },
      ),
    );
  }
}
