class DriverTripsResponse {
  final bool status;
  final String message;
  final DriverTripsData data;

  DriverTripsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DriverTripsResponse.fromJson(Map<String, dynamic> json) {
    return DriverTripsResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: DriverTripsData.fromJson(json['data'] ?? {}),
    );
  }
}
class DriverTripsData {
  final List<DriverTrip> upcoming;
  final List<DriverTrip> goingOn;
  final List<DriverTrip> completed;

  DriverTripsData({
    required this.upcoming,
    required this.goingOn,
    required this.completed,
  });

  factory DriverTripsData.fromJson(Map<String, dynamic> json) {
    return DriverTripsData(
      upcoming: _parseTrips(json['upcoming']),
      goingOn: _parseTrips(json['goingOn']),
      completed: _parseTrips(json['completed']),
    );
  }

  static List<DriverTrip> _parseTrips(dynamic list) {
    if (list == null || list is! List) return [];
    return list
        .where((e) => e is Map<String, dynamic> && e.isNotEmpty)
        .map((e) => DriverTrip.fromJson(e))
        .toList();
  }
}
class DriverTrip {
  final String id;
  final String routeId;
  final String tripStartDate;
  final String tripStartTime;
  final String tripEndDate;
  final String tripEndTime;
  final String busId;
  final String policyId;
  final String driverId;
  final String? helperId;
  final String? conductorId;
  final int extraSeats;
  final String status;
  final String deletedStatus;
  final String tripStatus;
  final String? statusRemark;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? punchIn;
  final String? punchOut;

  DriverTrip({
    required this.id,
    required this.routeId,
    required this.tripStartDate,
    required this.tripStartTime,
    required this.tripEndDate,
    required this.tripEndTime,
    required this.busId,
    required this.policyId,
    required this.driverId,
    this.helperId,
    this.conductorId,
    required this.extraSeats,
    required this.status,
    required this.deletedStatus,
    required this.tripStatus,
    this.statusRemark,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.punchIn,
    this.punchOut,
  });

  factory DriverTrip.fromJson(Map<String, dynamic> json) {
    return DriverTrip(
      id: json['id'] ?? '',
      routeId: json['route_id'] ?? '',
      tripStartDate: json['trip_start_date'] ?? '',
      tripStartTime: json['trip_start_time'] ?? '',
      tripEndDate: json['trip_end_date'] ?? '',
      tripEndTime: json['trip_end_time'] ?? '',
      busId: json['bus_id'] ?? '',
      policyId: json['policy_id'] ?? '',
      driverId: json['driver_id'] ?? '',
      helperId: json['helper_id'],
      conductorId: json['conductor_id'],
      extraSeats: json['extra_seats'] ?? 0,
      status: json['status'] ?? '',
      deletedStatus: json['deleted_status'] ?? '',
      tripStatus: json['trip_status'] ?? '',
      statusRemark: json['status_remark'],
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      punchIn: json['punch_in'],
      punchOut: json['punch_out'],
    );
  }
}
