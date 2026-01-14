import 'package:flutter/material.dart';

class PickupDropScreen extends StatelessWidget {
  const PickupDropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pickup & Drop Points")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            title: Text("Ram Mandir (East)"),
            subtitle: Text("Pal Nagar, Near Bhaidas Hall"),
            trailing: Text("12:00 PM"),
          ),
          ListTile(
            title: Text("Borivali West"),
            subtitle: Text("Gokuldham Society"),
            trailing: Text("10:00 AM"),
          ),
        ],
      ),
    );
  }
}
