import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';
import 'package:go_bus_driver_app/core/constants/app_strings.dart';
import 'package:go_bus_driver_app/core/utils/app_toast.dart';
import 'package:go_bus_driver_app/core/utils/app_utils.dart';
import 'package:go_bus_driver_app/core/widgets/time_bubble.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_event.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_state.dart';
import 'package:go_bus_driver_app/data/models/punchin/trip_punchin_request_model.dart';
import 'package:go_bus_driver_app/data/models/trip/driver_trip_response_model.dart';
import 'package:go_bus_driver_app/routes/route_paths.dart';
import 'package:go_router/go_router.dart';

class UpcomingTab extends StatelessWidget {
  const UpcomingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripBloc, TripState>(
      listener: (context, state) {
        if (state is TripError) {
          AppToast.show(context, message: state.message, type: ToastType.error);
          context.read<TripBloc>().add(FetchDriverTrips());
        }
      },
      child: BlocBuilder<TripBloc, TripState>(
        builder: (context, state) {
          if (state is TripLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TripLoaded) {
            final trips = state.response.data!.upcoming.toList();

            if (trips.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No completed trips",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      icon: const Icon(Icons.refresh, color: AppColors.white),
                      label: const Text(
                        "Refresh",
                        style: TextStyle(color: AppColors.white),
                      ),
                      onPressed: () {
                        context.read<TripBloc>().add(
                              FetchDriverTrips(), // 🔥 use your actual fetch event
                            );
                      },
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                context.read<TripBloc>().add(FetchDriverTrips());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  return _tripCard(context, trips[index]);
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _tripCard(BuildContext context, DriverTrip trip) {
    final bool isPunchedIn = trip.punchIn != null;

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
          /// Cities
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    trip.route?.startFrom ?? "--",
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(color: Colors.grey, thickness: 1),
                      ),
                      const SizedBox(width: 6),
                      SvgPicture.asset(
                        AppStrings.fromToBus,
                        width: 24,
                        height: 24,
                        color: AppColors.grey, // optional
                      ),
                      const SizedBox(width: 6),
                      const Expanded(
                        child: Divider(color: Colors.grey, thickness: 1),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    trip.route?.endAt ?? "--",
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// Schedule + Bus
          _infoBox(trip),

          const SizedBox(height: 22),

          /// Timeline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bubbleWithLabel("Start", formatTime(trip.tripStartTime)),
              bubbleWithLabel("End", formatTime(trip.tripEndTime)),
            ],
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: timelineRow(
              "${calculateTotalHours(trip.tripStartTime, trip.tripEndTime)} h",
            ),
          ),

          const SizedBox(height: 22),

          /// Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.push(RoutePaths.route, extra: trip.id),
                child: const Text(
                  "Route Details",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: isPunchedIn
                    ? null
                    : () => _showPunchInConfirmation(context, trip),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isPunchedIn ? Colors.grey.shade300 : Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isPunchedIn ? "Punched" : "Punch In",
                    style: TextStyle(
                      color: isPunchedIn ? Colors.grey.shade700 : Colors.white,
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

  Future<void> _showPunchInConfirmation(
    BuildContext context,
    DriverTrip trip,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Confirm Punch-In",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Are you sure you want to punch in for this trip?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                "Punch In",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      context.read<TripBloc>().add(
            SubmitTripStatus(
              TripStatusRequest(
                tripId: trip.id,
                status: "punch_in",
              ),
            ),
          );
    }
  }

  Widget _infoBox(DriverTrip trip) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text("SCHEDULE DATE", style: TextStyle(fontSize: 11)),
              ),
              Text(
                trip.tripStartDate ?? "--",
                style: const TextStyle(color: Color(0xFFFF6A00)),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Expanded(
                child: Text("BUS NAME & NO.", style: TextStyle(fontSize: 11)),
              ),
              Text(
                "${trip.bus?.busName} ${trip.bus?.registrationNumber}",
                style: const TextStyle(color: Color(0xFFBF360C)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

int calculateTotalHours(String startTime, String endTime) {
  DateTime _parse(String time) {
    final parts = time.split(':');
    return DateTime(
      2025,
      1,
      1,
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  final start = _parse(startTime);
  final end = _parse(endTime);

  // if end is before start => add 1 day
  final actualEnd = end.isBefore(start) ? end.add(Duration(days: 1)) : end;

  final duration = actualEnd.difference(start);

  return duration.inHours;
}

Widget timelineRow(String hours) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: AppColors.blue,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 7),
      Expanded(child: DashedLineWithHours(hours: hours)),
      const SizedBox(width: 7),
      Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
    ],
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

extension TripCopyWith on DriverTrip {
  DriverTrip copyWith({String? punchIn, String? punchOut}) {
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
