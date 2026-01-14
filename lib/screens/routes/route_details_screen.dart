import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/core/widgets/app_header.dart';

class RouteDetailsScreen extends StatefulWidget {
  const RouteDetailsScreen({super.key});

  @override
  State<RouteDetailsScreen> createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  // Timeline data
  final List<Map<String, dynamic>> pickupPoints = [
    {
      "time": "10:00",
      "date": "7 Oct",
      "name": "Borivali (West) - Gokuldham Society",
      "address": "Pill Nagar, Near Bhadala Hall, Ganeshwar Hotel, Borivali West",
    },
    {
      "time": "11:00",
      "date": "7 Oct",
      "name": "Borivali (West) - Gokuldham Society",
      "address": "Pill Nagar, Near Bhadala Hall, Ganeshwar Hotel, Borivali West",
    },
  ];

  final List<Map<String, dynamic>> restStops = [
    {
      "time": "12:00",
      "date": "7 Oct",
      "name": "Ram Mandir (East)",
      "address": "Pill Nagar, Near Bhadala Hall, Ganeshwar Hotel, Borivali West",
    }
  ];

  final List<Map<String, dynamic>> dropPoints = [
    {
      "time": "10:00",
      "date": "7 Oct",
      "name": "Borivali (West) - Gokuldham Society",
      "address": "Pill Nagar, Near Bhadala Hall, Ganeshwar Hotel, Borivali West",
    }
  ];

  // Sample JSON passengers data
  final List<Map<String, dynamic>> passengers = [
    {
      "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
      "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
      "seat_number": "12A",
      "boarded_status": "pending",
      "passenger_name": "John Doe",
      "gender": "Male",
      "age": 32,
      "health_issue": "None",
      "contact_number": "9876543210",
      "infant": "no"
    },
    {
      "booking_id": "b45g3f99-c39f-5c90-1bbc-2e421d349c33",
      "boarded_id": "882bf9d3-64dd-5g83-8818-5e20aa8b923f",
      "seat_number": "13B",
      "boarded_status": "pending",
      "passenger_name": "Jane Smith",
      "gender": "Female",
      "age": 28,
      "health_issue": "Asthma",
      "contact_number": "9123456780",
      "infant": "no"
    },
  ];

  // ---------------- Timeline constants ----------------
  static const double _timeWidth = 55;
  static const double _gapBetweenTimeAndLine = 12;
  static const double _lineContainerWidth = 18;
  static const double _lineThickness = 3;
  static const double _dotSize = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(child: GoBusHeader(showBackButton: true)),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 16),
            const Text(
              "Route Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            _buildTimelineSection("Pickup Point", pickupPoints, Icons.location_on),
            const SizedBox(height: 20),
            _buildTimelineSection("Rest Stop", restStops, Icons.local_cafe),
            const SizedBox(height: 20),
            _buildTimelineSection("Dropping Point", dropPoints, Icons.flag),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget _buildTimelineSection(String title, List<Map<String, dynamic>> stops, IconData icon) {
    if (stops.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: const Text(
          "No points available",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(title),
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  left: _timeWidth + _gapBetweenTimeAndLine + (_lineContainerWidth - _lineThickness) / 2,
                  top: 0,
                  bottom: 0,
                  width: _lineThickness,
                  child: Container(color: Colors.grey.shade300),
                ),
                Column(
                  children: List.generate(stops.length, (index) {
                    final stop = stops[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              width: _timeWidth,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(stop["time"], textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                                  const SizedBox(height: 2),
                                  Text(stop["date"], style: const TextStyle(fontSize: 11, color: Colors.black45)),
                                ],
                              ),
                            ),
                            const SizedBox(width: _gapBetweenTimeAndLine),
                            SizedBox(
                              width: _lineContainerWidth,
                              child: Center(
                                child: Container(
                                  width: _dotSize,
                                  height: _dotSize,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 1),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(stop["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text(stop["address"], style: const TextStyle(fontSize: 12, color: Colors.black54)),
                                  const SizedBox(height: 6),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        backgroundColor: Colors.blue.shade50,
                                        minimumSize: Size.zero,
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      ),
                                      onPressed: () {
                                        showPassengerDialog(context);
                                      },
                                      child: const Text("Passengers", style: TextStyle(fontSize: 12, color: Colors.blue)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void showPassengerDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          "Passenger Details",
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: ConstrainedBox(
    constraints: const BoxConstraints(minWidth: 700),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 450),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER ROW
            Row(
              children: const [
                _HeaderCell("Passenger Name"),
                _HeaderCell("Gender"),
                _HeaderCell("Contact No"),
                _HeaderCell("Seat No."),
                _HeaderCell("Health Issue"),
                _HeaderCell("Status"),
              ],
            ),
            const SizedBox(height: 6),

            // DATA ROWS
            ...passengers.map<Widget>((passenger) {
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _ValueCell(passenger["passenger_name"]),
                    _ValueCell(passenger["gender"]),
                    _ValueCell(passenger["contact_number"]),
                    _ValueCell(passenger["seat_number"]),
                    _ValueCell(passenger["health_issue"]),
                    SizedBox(
                      width: 120,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              passenger["boarded_status"] == "boarded"
                                  ? Colors.green
                                  : Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () async {
                          bool? confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Confirm Status Change"),
                              content: const Text(
                                  "Do you want to mark this passenger as boarded?"),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("No")),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Yes")),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            setState(() {
                              passenger["boarded_status"] = "boarded";
                            });
                          }
                        },
                        child: Text(
                          passenger["boarded_status"].toString().toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    ),
  ),
),
const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.black54,
        ),
      ),
    );
  }
}


class _ValueCell extends StatelessWidget {
  final String text;
  const _ValueCell(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}
