import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/data/models/trip/driver_trip_response_model.dart';
import 'package:go_bus_driver_app/routes/route_paths.dart';
import 'package:go_router/go_router.dart';

class UpcomingTab extends StatefulWidget {
  final DriverTripsResponse trips;

  const UpcomingTab({super.key, required this.trips});

  @override
  State<UpcomingTab> createState() => _UpcomingTabState();
}

class _UpcomingTabState extends State<UpcomingTab> {
  late List<DriverTrip> trips;

  @override
  void initState() {
    super.initState();
    trips = widget.trips.data.upcoming;
  }

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return const Center(
        child: Text("No upcoming trips"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return _tripCard(context, trips[index], index);
      },
    );
  }

  Widget _tripCard(BuildContext context, DriverTrip trip, int index) {
    String fromCity = "Mumbai";
    String toCity = "Nashik";

    bool isPunchedIn = trip.punchIn != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 12,
            color: Colors.black.withOpacity(0.12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Cities + Bus icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(fromCity,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(width: 8),
              Container(height: 1, width: 30, color: Colors.grey.shade400),
              const SizedBox(width: 8),
              Icon(Icons.directions_bus, color: Colors.grey.shade700, size: 26),
              const SizedBox(width: 8),
              Container(height: 1, width: 30, color: Colors.grey.shade400),
              const SizedBox(width: 8),
              Text(toCity,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),

          const SizedBox(height: 16),

          // Info box: Schedule date & Bus Name/No
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
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      trip.tripStartDate ?? "6 October 2025",
                      style: const TextStyle(
                          color: Color(0xFFFF6A00),
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(color: Colors.grey.shade300, height: 1),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "BUS NAME & NO.",
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      trip.busId?.toString() ?? "Vighnhar MH47J1234",
                      style: const TextStyle(
                          color: Color(0xFFBF360C),
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // Time row: Start | Dotted line + duration | End
          Row(
            children: [
              _timeBox(trip.tripStartTime ?? "7:00 AM"),
              const SizedBox(width: 8),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: List.generate(
                            (constraints.maxWidth / 6).floor(),
                            (_) => Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "6 h",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              _timeBox(trip.tripEndTime ?? "13:00 PM"),
            ],
          ),

          const SizedBox(height: 22),

          // Footer: Route Details + Punch In button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.push(RoutePaths.route),
                child: const Text(
                  "Route Details",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: isPunchedIn
                    ? null
                    : () {
                        setState(() {
                          trips[index] = trips[index].copyWith(
                            punchIn: "1",
                          );
                        });
                      },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  decoration: BoxDecoration(
                    color: isPunchedIn ? Colors.grey.shade300 : Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isPunchedIn ? "Punched" : "Punch In",
                    style: TextStyle(
                      color: isPunchedIn ? Colors.grey.shade700 : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Small rounded box for start/end times
  Widget _timeBox(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        time,
        style: TextStyle(
          color: Colors.blue.shade700,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}

extension TripCopyWith on DriverTrip {
  DriverTrip copyWith({
    String? punchIn,
    String? punchOut,
  }) {
    return DriverTrip(
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
      punchIn: punchIn ?? this.punchIn,
      punchOut: punchOut ?? this.punchOut,
    );
  }
}