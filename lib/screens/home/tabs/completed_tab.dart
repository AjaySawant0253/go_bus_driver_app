import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';
import 'package:go_bus_driver_app/core/constants/app_strings.dart';
import 'package:go_bus_driver_app/core/utils/app_utils.dart';
import 'package:go_bus_driver_app/core/widgets/time_bubble.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_event.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_state.dart';
import 'package:go_bus_driver_app/data/models/trip/driver_trip_response_model.dart';

class CompletedTab extends StatefulWidget {
  const CompletedTab({super.key});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        if (state is TripLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TripError) {
          return Center(child: Text(state.message));
        }

        if (state is TripLoaded) {
          final trips = state.response.data!.completed;

          if (trips.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No completed trips",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                return _completedCard(context, trips[index]);
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  // ------------------------------------------------------------------
  // Completed Card
  // ------------------------------------------------------------------

  Widget _completedCard(BuildContext context, DriverTrip trip) {
    final String durationText = _calculateDuration(trip);

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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// Info Box
          _infoBox(trip),

          const SizedBox(height: 22),

          /// Punch In / Punch Out
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bubbleWithLabel(
                "Punch In",
                formatTime(trip.punchIn ?? trip.tripStartTime),
              ),
              bubbleWithLabel("Punch Out", formatTime(trip.punchOut)),
            ],
          ),

          const SizedBox(height: 14),

          /// Timeline with duration
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: timelineRow(durationText),
          ),

          const SizedBox(height: 18),

          /// Footer text
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

  // ------------------------------------------------------------------
  // Helpers
  // ------------------------------------------------------------------

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

  String _calculateDuration(DriverTrip trip) {
    if (trip.punchIn == null || trip.punchOut == null) return "--";

    try {
      final start = DateTime.parse(trip.punchIn!);
      final end = DateTime.parse(trip.punchOut!);
      final diff = end.difference(start);

      return "${diff.inHours} h ${diff.inMinutes % 60} min";
    } catch (_) {
      return "--";
    }
  }
}
