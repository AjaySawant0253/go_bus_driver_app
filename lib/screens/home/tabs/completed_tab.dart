import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';
import 'package:go_bus_driver_app/data/models/driver_trip_response_model.dart';
import 'package:go_bus_driver_app/routes/route_paths.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CompletedTab extends StatelessWidget {
  final DriverTripsResponse trips;

  const CompletedTab({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    final completedTrips = trips.data.completed;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: completedTrips.length,
      itemBuilder: (context, i) => _completedCard(context, completedTrips[i]),
    );
  }

  // ------------------------------------------------------------------------
  // Parse ISO DateTime string (e.g., "2025-11-22T17:40:00.000000Z")
  // ------------------------------------------------------------------------
  DateTime? _parseDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return null;
    
    try {
      return DateTime.parse(dateTimeString);
    } catch (_) {
      return null;
    }
  }

  // ------------------------------------------------------------------------
  // Extract time from DateTime and format to "7:40 PM"
  // ------------------------------------------------------------------------
  String _formatTimeFromISO(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return "Pending";
    
    final dateTime = _parseDateTime(dateTimeString);
    if (dateTime != null) {
      return DateFormat("h:mm a").format(dateTime);
    }
    
    // If parsing fails, try to parse as plain time string
    try {
      // Try common time formats as fallback
      final formats = [
        DateFormat("hh:mm a"),
        DateFormat("HH:mm"),
        DateFormat("HH:mm:ss"),
        DateFormat("hh:mm:ss a"),
      ];
      
      for (var f in formats) {
        try {
          final parsed = f.parse(dateTimeString);
          return DateFormat("h:mm a").format(parsed);
        } catch (_) {}
      }
    } catch (_) {}
    
    return "Invalid";
  }

  // ------------------------------------------------------------------------
  // Format date from ISO string (e.g., "22 November 2025")
  // ------------------------------------------------------------------------
  String _formatDateFromISO(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return "";
    
    final dateTime = _parseDateTime(dateTimeString);
    if (dateTime != null) {
      return DateFormat("dd MMMM yyyy").format(dateTime);
    }
    
    return dateTimeString;
  }

Widget _completedCard(BuildContext context, Trip trip) {
  String fromCity = "Mumbai";
  String toCity = "Nashik";

  // Parse Punch In/Out as DateTime
  final punchInDateTime = _parseDateTime(trip.punchIn);
  final punchOutDateTime = _parseDateTime(trip.punchOut);

  // Calculate duration
  String durationText = "";
  if (punchInDateTime != null && punchOutDateTime != null) {
    final diff = punchOutDateTime.difference(punchInDateTime);
    final hours = diff.inHours;
    final mins = diff.inMinutes % 60;
    durationText = "${hours}h ${mins}min";
  }

  // Format trip start date
  final formattedTripDate = _formatDateFromISO(trip.tripStartDate);

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xfff7f7f7),
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
                  Text(
                    formattedTripDate,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                    "Vighnhar ${trip.busId ?? ""}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFBF360C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
            // Punch In Column
            Column(
              children: [
                const Text("Punch in", style: TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 6),
                _bubbleSmall(_formatTimeFromISO(trip.punchIn)),
              ],
            ),

            // Punch Out Column
            Column(
              children: [
                const Text("Punch out", style: TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 6),
                _bubbleSmall(_formatTimeFromISO(trip.punchOut)),
              ],
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Dotted line with duration in center
        SizedBox(
          height: 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Dotted line
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
              
              // Duration text in center
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.orange, width: 1),
                ),
                child: Text(
                  durationText.isNotEmpty ? durationText : "--",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Only the "Completed" text (no chip/button)
        Text(
          "Duration Taken",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
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

  Widget _timeBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFD9E8FF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
      ),
    );
  }

  Widget _dot() {
    return Container(
      width: 7,
      height: 7,
      decoration: const BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
    );
  }
}