import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/data/models/driver_trip_response_model.dart';
import 'package:go_router/go_router.dart';
import 'package:go_bus_driver_app/routes/route_paths.dart';
import 'package:intl/intl.dart';

class OngoingTab extends StatefulWidget {
  final DriverTripsResponse trips;

  const OngoingTab({super.key, required this.trips});

  @override
  State<OngoingTab> createState() => _OngoingTabState();
}

class _OngoingTabState extends State<OngoingTab> {
  late List<Trip> trips;

  @override
  void initState() {
    super.initState();
    trips = widget.trips.data.goingOn;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      itemBuilder: (context, i) => _ongoingCard(context, trips[i]),
    );
  }

  // ------------------------------------------------------------------------
  // ONGOING CARD — EXACT LIKE SCREENSHOT
  // ------------------------------------------------------------------------

Widget _ongoingCard(BuildContext context, Trip trip) {
  String fromCity = "Mumbai";
  String toCity = "Nashik";

  String formatTime(String? time) {
    if (time == null || time.isEmpty) return "Pending";
    try {
      final parsed = DateFormat("HH:mm").parse(time);
      return DateFormat("h:mm a").format(parsed);
    } catch (_) {
      return time;
    }
  }

  // Local state for Punch Out
  String punchOutTime = trip.punchOut ?? "";

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xfff7f7f7), // grey background
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        // Header: Mumbai — bus — Nashik
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(fromCity,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(width: 6),
            Expanded(child: Divider(color: Colors.grey, thickness: 1)),
            const SizedBox(width: 6),
            Icon(Icons.directions_bus, color: Colors.grey[700], size: 22),
            const SizedBox(width: 6),
            Expanded(child: Divider(color: Colors.grey, thickness: 1)),
            const SizedBox(width: 6),
            Text(toCity,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          ],
        ),
        const SizedBox(height: 12),

        // Info box
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "SCHEDULE DATE",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ),
                  Text(trip.tripStartDate ?? "6 October 2025",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 6),
              Divider(color: Colors.black12),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "BUS NAME & NO.",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ),
                  Text(
                      "Vighnhar ${trip.busId ?? "MH47J1234"}",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFBF360C),
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Punch in / Punch out row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text("Punch in", style: TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 6),
                _bubbleSmall(formatTime(trip.tripStartTime)),
              ],
            ),
            Column(
              children: [
                const Text("Punch out", style: TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      punchOutTime =
                          DateFormat("h:mm a").format(DateTime.now());
                    });
                  },
                  child: _bubbleSmall(punchOutTime.isEmpty ? "Pending" : punchOutTime),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Dotted line with circular dots
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double dashWidth = 6;
                  double dashSpacing = 4;
                  int count =
                      (constraints.maxWidth / (dashWidth + dashSpacing)).floor();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(count, (_) {
                      return Container(
                        width: dashWidth,
                        height: 2,
                        color: Colors.orange,
                      );
                    }),
                  );
                },
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Buttons row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Route Details", style: TextStyle(color: Colors.blue)),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  punchOutTime =
                      DateFormat("h:mm a").format(DateTime.now());
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Punch Out"),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _bubbleSmall(String time) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xFFD9E8FF),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      time,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    ),
  );
}

  }

extension on Trip {
  Trip copyWith({String? punchOut}) {
    return Trip(
      id: id,
      routeId: routeId,
      tripStartDate: tripStartDate,
      tripStartTime: tripStartTime,
      tripEndDate: tripEndDate,
      tripEndTime: tripEndTime,
      busId: busId,
      policyId: policyId,
      driverId: driverId,
      helperId: helperId,
      conductorId: conductorId,
      extraSeats: extraSeats,
      status: status,
      deletedStatus: deletedStatus,
      tripStatus: tripStatus,
      statusRemark: statusRemark,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      punchIn: punchIn,
      punchOut: punchOut,
    );
  }
}
