import 'package:flutter/material.dart';

class PassengerDetailsScreen extends StatelessWidget {
  const PassengerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Passenger Details")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Passenger Name: Ajay Chorge"),
            Text("Gender: Male"),
            Text("Contact: 1234567890"),
            Text("Seat No: 22"),
            Text("Health Issue: No"),
            Text("Status: Pending"),
          ],
        ),
      ),
    );
  }
}
