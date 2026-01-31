import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';
import 'package:go_bus_driver_app/core/di/injection_container.dart';
import 'package:go_bus_driver_app/core/utils/app_utils.dart';
import 'package:go_bus_driver_app/core/widgets/app_header.dart';
import 'package:go_bus_driver_app/data/bloc/passenger/passenger_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/passenger/passenger_event.dart';
import 'package:go_bus_driver_app/data/bloc/route-details/trip_routes_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/route-details/trip_routes_event.dart';
import 'package:go_bus_driver_app/data/bloc/route-details/trip_routes_state.dart';
import 'package:go_bus_driver_app/screens/routes/passenger_dialog.dart';
import 'package:intl/intl.dart';

class RouteDetailsScreen extends StatefulWidget {
  final String tripId;
  final String tabName;

  const RouteDetailsScreen(
      {super.key, required this.tripId, required this.tabName});

  @override
  State<RouteDetailsScreen> createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  static const double _timeWidth = 60;
  static const double _gapBetweenTimeAndLine = 12;
  static const double _lineContainerWidth = 18;
  static const double _lineThickness = 3;
  static const double _dotSize = 7;

  @override
  void initState() {
    super.initState();
    context.read<TripRoutesBloc>().add(FetchTripRoutes(widget.tripId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(child: GoBusHeader(showBackButton: true)),
      ),
      body: BlocBuilder<TripRoutesBloc, TripRoutesState>(
        builder: (context, state) {
          if (state is TripRoutesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TripRoutesError) {
            return Center(child: Text(state.message));
          }

          if (state is TripRoutesLoaded) {
            final route = state.response.data.first;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Route Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                _buildTimelineSection(
                  "Pickup Point",
                  route.pickupPoints,
                  Icons.near_me,
                  Colors.green,
                ),
                const SizedBox(height: 20),
                _buildTimelineSection(
                  "Rest Stop",
                  route.restPoints,
                  Icons.local_cafe,
                  Colors.orange,
                ),
                const SizedBox(height: 20),
                _buildTimelineSection(
                  "Dropping Point",
                  route.dropPoints,
                  Icons.flag,
                  Colors.red,
                ),
                const SizedBox(height: 80),
              ],
            );
          }

          return const SizedBox();
        },
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

  Widget _buildTimelineSection(
    String title,
    List<dynamic> stops,
    IconData icon,
    Color iconColor,
  ) {
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
                  left: _timeWidth +
                      _gapBetweenTimeAndLine +
                      (_lineContainerWidth - _lineThickness) / 2,
                  top: 0,
                  bottom: 0,
                  width: _lineThickness,
                  child: Container(color: Colors.grey.shade300),
                ),
                Column(
                  children: List.generate(stops.length, (index) {
                    final stop = stops[index];

                    // Fix for DateTime vs String
                    final dateTime = stop.arrival is String
                        ? DateTime.parse(stop.arrival)
                        : stop.arrival as DateTime;

                    final formattedTime = DateFormat('h:mm a').format(dateTime);
                    final formattedDate = DateFormat('dd MMM').format(dateTime);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              width: _timeWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    formattedTime,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                    maxLines: 1, // FIX time overflow
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.black45,
                                    ),
                                  ),
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
                                    color: iconColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          stop.stopName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Icon(icon, size: 18, color: iconColor),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    stop.address,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  if (stop.mapLink != null &&
                                      stop.mapLink.isNotEmpty) ...[
                                    const SizedBox(height: 6),
                                    GestureDetector(
                                      onTap: () {
                                        openMapLink(stop.mapLink);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.map,
                                            size: 14,
                                            color: Colors.blue,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "View on Map",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 8),
                                  Visibility(
                                    visible: title == "Pickup Point"
                                    &&
                                     widget.tabName == "Ongoing",
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          backgroundColor: Colors.blue.shade50,
                                          minimumSize: Size.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (_) =>
                                                BlocProvider<PassengerBloc>(
                                              create: (_) => sl<PassengerBloc>()
                                                ..add(
                                                  FetchPassengersEvent(
                                                    tripId: widget.tripId,
                                                    pickupId: stop.id,
                                                  ),
                                                ),
                                              child: PassengerDialog(
                                                pickupId: stop.id,
                                                stopName: stop.stopName,
                                                stopAddress: stop.address,
                                                tripId: widget.tripId,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Passengers",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
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
}

class _HeaderCell extends StatelessWidget {
  final String title;
  final double width;

  const _HeaderCell(this.title, {required this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}

class _ValueCell extends StatelessWidget {
  final String value;
  final double width;

  const _ValueCell(this.value, {required this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(value, style: const TextStyle(fontSize: 14)),
    );
  }
}

class _VerticalLine extends StatelessWidget {
  const _VerticalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 24,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
