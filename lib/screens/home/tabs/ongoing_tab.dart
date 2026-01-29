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
import 'package:go_bus_driver_app/screens/home/tabs/upcoming_tab.dart'
    hide timelineRow;
import 'package:go_router/go_router.dart';
import 'package:go_bus_driver_app/routes/route_paths.dart';
import 'package:intl/intl.dart';

class OngoingTab extends StatefulWidget {
  const OngoingTab({super.key});

  @override
  State<OngoingTab> createState() => _OngoingTabState();
}

class _OngoingTabState extends State<OngoingTab> {
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
            final trips = state.response.data.goingOn;

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
                      icon: const Icon(Icons.refresh,color: AppColors.white,),
                      label: const Text("Refresh",style: TextStyle(color: AppColors.white),),
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
                  return _ongoingCard(context, trips[index]);
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  // ------------------------------------------------------------------
  // Ongoing Card
  // ------------------------------------------------------------------

  Widget _ongoingCard(BuildContext context, DriverTrip trip) {
    final bool isPunchedOut = trip.punchOut != null;

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
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
              bubbleWithLabel(
                "Punch Out",
                trip.punchOut == null ? "Pending" : formatTime(trip.punchOut!),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// Timeline
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
                onTap: isPunchedOut
                    ? null
                    : () {
                        context.read<TripBloc>().add(
                          SubmitTripStatus(
                            TripStatusRequest(
                              tripId: trip.id,
                              status: "punch_out",
                            ),
                          ),
                        );
                      },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isPunchedOut ? Colors.grey.shade300 : Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isPunchedOut ? "Punched Out" : "Punch Out",
                    style: TextStyle(
                      color: isPunchedOut ? Colors.grey.shade700 : Colors.white,
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
