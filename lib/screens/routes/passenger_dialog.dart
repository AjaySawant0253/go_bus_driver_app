import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/core/utils/app_toast.dart';
import 'package:go_bus_driver_app/data/bloc/passenger/passenger_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/passenger/passenger_event.dart';
import 'package:go_bus_driver_app/data/bloc/passenger/passenger_state.dart';
import 'package:go_bus_driver_app/data/models/passenger/passenger_response.dart';

class PassengerDialog extends StatefulWidget {
  final String stopName;
  final String stopAddress;
  final String pickupId;
  final String tripId;

  const PassengerDialog({
    super.key,
    required this.stopName,
    required this.stopAddress,
    required this.pickupId,
    required this.tripId,
  });

  @override
  State<PassengerDialog> createState() => _PassengerDialogState();
}

class _PassengerDialogState extends State<PassengerDialog> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  static const double tableWidth = 780;

  @override
  void initState() {
    super.initState();
    // context.read<PassengerBloc>().add(
    //   FetchPassengersEvent(tripId: widget.tripId, pickupId: widget.pickupId),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            const Divider(height: 1),

            // 👇 Use BlocConsumer instead of BlocBuilder
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 360,
                child: BlocConsumer<PassengerBloc, PassengerState>(
                  listener: (context, state) {
                    // 🔥 When boarding success, reload passengers
                    if (state is PassengerBoardingSuccess) {
                      AppToast.show(
                        context,
                        message: "Boarding Successful",
                        type: ToastType.success,
                      );

                      context.read<PassengerBloc>().add(
                        FetchPassengersEvent(
                          tripId: widget.tripId,
                          pickupId: widget.pickupId,
                        ),
                      );
                    }

                    if (state is PassengerBoardingError) {
                      AppToast.show(
                        context,
                        message: state.message,
                        type: ToastType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is PassengerLoading ||
                        state is PassengerBoardingLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is PassengerError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is PassengerLoaded) {
                      final passengers = state.passengers.data;

                      if (passengers.isEmpty) {
                        return const Center(child: Text("No passengers found"));
                      }

                      return Scrollbar(
                        controller: _horizontalController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: _horizontalController,
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: tableWidth,
                            child: Column(
                              children: [
                                _buildTableHeader(),
                                const Divider(height: 1, thickness: 2),

                                Expanded(
                                  child: Scrollbar(
                                    controller: _verticalController,
                                    thumbVisibility: true,
                                    child: ListView.builder(
                                      controller: _verticalController,
                                      itemCount: passengers.length,
                                      itemBuilder: (_, index) =>
                                          _buildRow(passengers[index]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ),

            _buildCloseButton(),
          ],
        ),
      ),
    );
  }

  // ... rest of your code (header, table header, rows, buttons)



  // ================= HEADER =================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Passenger Details ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            TextSpan(
              text: "- ${widget.stopName}\n",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: widget.stopAddress,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= TABLE HEADER =================

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: const [
          _HeaderCell("Passenger Name", 160),
          _VerticalLine(),
          _HeaderCell("Gender", 80),
          _VerticalLine(),
          _HeaderCell("Contact No", 140),
          _VerticalLine(),
          _HeaderCell("Seat No.", 80),
          _VerticalLine(),
          _HeaderCell("Health Issue", 120),
          _VerticalLine(),
          _HeaderCell("Status", 100),
        ],
      ),
    );
  }

  // ================= ROW =================

  Widget _buildRow(Passenger p) {
    final bool isBoarded = p.boardedStatus == "1";

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              _Cell(p.passengerName, 160),
              const _VerticalLine(),
              _Cell(p.gender, 80),
              const _VerticalLine(),
              _Cell(p.contactNumber, 140),
              const _VerticalLine(),
              _Cell(p.seatNumber, 80),
              const _VerticalLine(),
              _Cell(p.healthIssue, 120),
              _StatusButton(isBoarded, p.boardedId),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }

  // ================= CLOSE BUTTON =================

  Widget _buildCloseButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text("Close"),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final double width;

  const _HeaderCell(this.text, this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class _Cell extends StatelessWidget {
  final String text;
  final double width;

  const _Cell(this.text, this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: Text(text));
  }
}

class _VerticalLine extends StatelessWidget {
  const _VerticalLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 24,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}

class _StatusButton extends StatelessWidget {
  final bool boarded;
  final String boardedId;

  const _StatusButton(this.boarded, this.boardedId);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 28,
      child: ElevatedButton(
        onPressed: boarded
            ? null
            : () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Confirm Boarding"),
                    content: const Text(
                      "Are you sure you want to mark as boarded?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<PassengerBloc>().add(
                            ConfirmBoardingEvent(boardedId: boardedId),
                          );
                        },
                        child: const Text("Confirm"),
                      ),
                    ],
                  ),
                );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: boarded ? Colors.green : Colors.red,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          boarded ? "Boarded" : "Pending",
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
