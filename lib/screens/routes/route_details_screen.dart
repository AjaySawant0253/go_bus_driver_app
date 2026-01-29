import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';
import 'package:go_bus_driver_app/core/di/injection_container.dart';
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

  const RouteDetailsScreen({super.key, required this.tripId});

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

  // void showPassengerDialog(
  //   BuildContext context,
  //   String stopName,
  //   String stopAddress,
  // ) {
  //   final ScrollController horizontalController = ScrollController();
  //   final ScrollController verticalController = ScrollController();
  //   const double tableWidth = 780;
  //   final List<Map<String, dynamic>> passengers = [
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "a34f2d88-b38f-4b89-9ccd-1e311c239b22",
  //       "boarded_id": "772af8d2-53cc-4f72-9807-4d19ea7a912a",
  //       "seat_number": "22",
  //       "boarded_status": "pickup",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 32,
  //       "health_issue": "No",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //     {
  //       "booking_id": "b45g3f99-c39f-5c90-1bbc-2e421d349c33",
  //       "boarded_id": "882bf9d3-64dd-5g83-8818-5e20aa8b923f",
  //       "seat_number": "22",
  //       "boarded_status": "boarded",
  //       "passenger_name": "Ajay Chorge",
  //       "gender": "Male",
  //       "age": 28,
  //       "health_issue": "Yes",
  //       "contact_number": "1234567890",
  //       "infant": "no",
  //     },
  //   ];

  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         child: Container(
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               // Header
  //               Container(
  //                 width: double.infinity,
  //                 padding: const EdgeInsets.symmetric(
  //                   vertical: 12,
  //                   horizontal: 12,
  //                 ),
  //                 child: RichText(
  //                   text: TextSpan(
  //                     children: [
  //                       const TextSpan(
  //                         text: "Passenger Details ",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 18,
  //                           color: Colors.blue,
  //                         ),
  //                       ),
  //                       TextSpan(
  //                         text: "- $stopName -\n",
  //                         style: const TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 18,
  //                           color: Colors.black,
  //                         ),
  //                       ),
  //                       // Address below stop name
  //                       TextSpan(
  //                         text: stopAddress,
  //                         style: const TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 14,
  //                           color: AppColors.grey,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),

  //               const Divider(height: 1),

  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: SizedBox(
  //                   height: 360,
  //                   child: Scrollbar(
  //                     controller: horizontalController,
  //                     thumbVisibility: true,
  //                     child: SingleChildScrollView(
  //                       controller: horizontalController,
  //                       scrollDirection: Axis.horizontal,
  //                       child: SizedBox(
  //                         width: tableWidth,
  //                         child: Column(
  //                           children: [
  //                             // ===== HEADER ROW (ALIGNED) =====
  //                             Padding(
  //                               padding: const EdgeInsets.symmetric(
  //                                 vertical: 8,
  //                               ),
  //                               child: Row(
  //                                 children: const [
  //                                   SizedBox(
  //                                     width: 160,
  //                                     child: Text(
  //                                       "Passenger Name",
  //                                       style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   _VerticalLine(),
  //                                   SizedBox(
  //                                     width: 80,
  //                                     child: Text(
  //                                       "Gender",
  //                                       style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   _VerticalLine(),
  //                                   SizedBox(
  //                                     width: 140,
  //                                     child: Text(
  //                                       "Contact No",
  //                                       style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   _VerticalLine(),
  //                                   SizedBox(
  //                                     width: 80,
  //                                     child: Text(
  //                                       "Seat No.",
  //                                       style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   _VerticalLine(),
  //                                   SizedBox(
  //                                     width: 120,
  //                                     child: Text(
  //                                       "Health Issue",
  //                                       style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   _VerticalLine(),
  //                                   SizedBox(
  //                                     width: 60,
  //                                     child: Text(
  //                                       "Status",
  //                                       style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),

  //                             const Divider(height: 1),

  //                             // ===== SCROLLABLE CONTENT ONLY =====
  //                             Expanded(
  //                               child: Scrollbar(
  //                                 controller: verticalController,
  //                                 thumbVisibility: true,
  //                                 child: ListView.builder(
  //                                   controller: verticalController,
  //                                   itemCount: passengers.length,
  //                                   itemBuilder: (context, index) {
  //                                     final p = passengers[index];
  //                                     return Column(
  //                                       children: [
  //                                         Padding(
  //                                           padding: const EdgeInsets.symmetric(
  //                                             vertical: 8,
  //                                           ),
  //                                           child: Row(
  //                                             children: [
  //                                               SizedBox(
  //                                                 width: 160,
  //                                                 child: Text(
  //                                                   p["passenger_name"],
  //                                                 ),
  //                                               ),
  //                                               _VerticalLine(),
  //                                               SizedBox(
  //                                                 width: 80,
  //                                                 child: Text(p["gender"]),
  //                                               ),
  //                                               _VerticalLine(),
  //                                               SizedBox(
  //                                                 width: 140,
  //                                                 child: Text(
  //                                                   p["contact_number"],
  //                                                 ),
  //                                               ),
  //                                               _VerticalLine(),
  //                                               SizedBox(
  //                                                 width: 80,
  //                                                 child: Text(p["seat_number"]),
  //                                               ),
  //                                               _VerticalLine(),
  //                                               SizedBox(
  //                                                 width: 120,
  //                                                 child: Text(
  //                                                   p["health_issue"],
  //                                                 ),
  //                                               ),
  //                                               SizedBox(
  //                                                 width:
  //                                                     120, // ⬅️ smaller width
  //                                                 height:
  //                                                     32, // ⬅️ smaller height
  //                                                 child: ElevatedButton(
  //                                                   style: ElevatedButton.styleFrom(
  //                                                     backgroundColor:
  //                                                         p["boarded_status"] ==
  //                                                             "boarded"
  //                                                         ? Colors.green
  //                                                         : Colors.red,
  //                                                     padding: EdgeInsets
  //                                                         .zero, // ⬅️ tighter button
  //                                                     shape: RoundedRectangleBorder(
  //                                                       borderRadius:
  //                                                           BorderRadius.circular(
  //                                                             16,
  //                                                           ),
  //                                                     ),
  //                                                   ),
  //                                                   onPressed: () {},
  //                                                   child: Text(
  //                                                     p["boarded_status"] ==
  //                                                             "boarded"
  //                                                         ? "Boarded"
  //                                                         : "Pending",
  //                                                     style: const TextStyle(
  //                                                       fontSize: 11,
  //                                                       fontWeight:
  //                                                           FontWeight.bold,
  //                                                       color: Colors.white,
  //                                                     ),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ),
  //                                         const Divider(height: 1,thickness: 2,),
  //                                       ],
  //                                     );
  //                                   },
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),

  //               // Close Button
  //               Padding(
  //                 padding: const EdgeInsets.only(bottom: 12),
  //                 child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: Colors.blue,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                   ),
  //                   onPressed: () => Navigator.pop(context),
  //                   child: const Text("Close"),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

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
                  left:
                      _timeWidth +
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
                                  const SizedBox(height: 8),
                                  Align(
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
                                                create: (_) =>
                                                    sl<PassengerBloc>()..add(
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
