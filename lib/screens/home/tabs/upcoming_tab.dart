import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/data/models/driver_trip_response_model.dart';
import 'package:go_bus_driver_app/routes/route_paths.dart';
import 'package:go_router/go_router.dart';

class UpcomingTab extends StatefulWidget {
  final DriverTripsResponse trips;

  const UpcomingTab({super.key, required this.trips});

  @override
  State<UpcomingTab> createState() => _UpcomingTabState();
}

class _UpcomingTabState extends State<UpcomingTab> {
  late List<Trip> trips;

  @override
  void initState() {
    super.initState();
    trips = widget.trips.data.upcoming;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return _tripCard(context, trips[index], index);
      },
    );
  }

  Widget _tripCard(BuildContext context, Trip trip, int index) {
    // Temporary city placeholders
    String fromCity = "Mumbai";
    String toCity = "Nashik";

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
          // Header: Cities and Bus Icon
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

          // White info box: Schedule Date & Bus Name
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Schedule Date
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "SCHEDULE DATE",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      trip.tripStartDate ?? "6 October 2025",
                      style: const TextStyle(
                        color: Color(0xFFFF6A00),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(color: Colors.grey.shade300, height: 1),
                const SizedBox(height: 8),
                // Bus Name & Number
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "BUS NAME & NO.",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      trip.busId != null
                          ? "${trip.busId}"
                          : "Vighnhar MH47J1234",
                      style: const TextStyle(
                        color: Color(0xFFBF360C),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // Time Row: Start | Dotted Line + Duration | End
          Row(
            children: [
              // Start Time
              _timeBox(trip.tripStartTime ?? "7:00 AM"),
              const SizedBox(width: 8),

              // Dotted line + Duration
              Expanded(
                child: Column(
                  children: [
                    LayoutBuilder(builder: (context, constraints) {
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
                                    )),
                          ),
                          Text(
                            "6 h",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // End Time
              _timeBox(trip.tripEndTime ?? "13:00 PM"),
            ],
          ),

          const SizedBox(height: 22),

          // Footer: Route Details + Punch Button
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
                    fontSize: 14,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    trips[index] = Trip(
                      id: trip.id,
                      routeId: trip.routeId,
                      tripStartDate: trip.tripStartDate,
                      tripStartTime: trip.tripStartTime,
                      tripEndDate: trip.tripEndDate,
                      tripEndTime: trip.tripEndTime,
                      busId: trip.busId,
                      policyId: trip.policyId,
                      driverId: trip.driverId,
                      helperId: trip.helperId,
                      conductorId: trip.conductorId,
                      extraSeats: trip.extraSeats,
                      status: trip.status,
                      deletedStatus: trip.deletedStatus,
                      tripStatus: trip.tripStatus,
                      statusRemark: trip.statusRemark,
                      createdBy: trip.createdBy,
                      updatedBy: trip.updatedBy,
                      createdAt: trip.createdAt,
                      updatedAt: trip.updatedAt,
                      punchIn: trip.punchIn == null ? "1" : null,
                      punchOut: trip.punchOut,
                    );
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  decoration: BoxDecoration(
                    color: trip.punchIn == null
                        ? Colors.green
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    trip.punchIn == null ? "Punch In" : "Punched",
                    style: TextStyle(
                      color: trip.punchIn == null
                          ? Colors.white
                          : Colors.grey.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // Rounded blue box for Start / End times
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
