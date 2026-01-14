class DriverTripsResponse {
  final bool status;
  final String message;
  final TripsData data;

  DriverTripsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DriverTripsResponse.fromJson(Map<String, dynamic> json) {
    return DriverTripsResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? "",
      data: TripsData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class TripsData {
  final List<Trip> upcoming;
  final List<Trip> goingOn;
  final List<Trip> completed;

  TripsData({
    required this.upcoming,
    required this.goingOn,
    required this.completed,
  });

  factory TripsData.fromJson(Map<String, dynamic> json) {
    return TripsData(
      upcoming: (json['upcoming'] as List? ?? [])
          .map((e) => Trip.fromJson(e))
          .toList(),
      goingOn: (json['goingOn'] as List? ?? [])
          .map((e) => Trip.fromJson(e))
          .toList(),
      completed: (json['completed'] as List? ?? [])
          .map((e) => Trip.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "upcoming": upcoming.map((e) => e.toJson()).toList(),
        "goingOn": goingOn.map((e) => e.toJson()).toList(),
        "completed": completed.map((e) => e.toJson()).toList(),
      };
}

class Trip {
  final String? id;
  final String? routeId;
  final String? tripStartDate;
  final String? tripStartTime;
  final String? tripEndDate;
  final String? tripEndTime;
  final String? busId;
  final String? policyId;
  final String? driverId;
  final String? helperId;
  final String? conductorId;
  final int? extraSeats;
  final String? status;
  final String? deletedStatus;
  final String? tripStatus;
  final String? statusRemark;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final String? punchOut;
  final String? punchIn;

  Trip({
    this.id,
    this.routeId,
    this.tripStartDate,
    this.tripStartTime,
    this.tripEndDate,
    this.tripEndTime,
    this.busId,
    this.policyId,
    this.driverId,
    this.helperId,
    this.conductorId,
    this.extraSeats,
    this.status,
    this.deletedStatus,
    this.tripStatus,
    this.statusRemark,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.punchOut,
    this.punchIn,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      routeId: json['route_id'],
      tripStartDate: json['trip_start_date'],
      tripStartTime: json['trip_start_time'],
      tripEndDate: json['trip_end_date'],
      tripEndTime: json['trip_end_time'],
      busId: json['bus_id'],
      policyId: json['policy_id'],
      driverId: json['driver_id'],
      helperId: json['helper_id'],
      conductorId: json['conductor_id'],
      extraSeats: json['extra_seats'],
      status: json['status'],
      deletedStatus: json['deleted_status'],
      tripStatus: json['trip_status'],
      statusRemark: json['status_remark'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      punchOut: json['punch_out'],
      punchIn: json['punch_in'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "route_id": routeId,
        "trip_start_date": tripStartDate,
        "trip_start_time": tripStartTime,
        "trip_end_date": tripEndDate,
        "trip_end_time": tripEndTime,
        "bus_id": busId,
        "policy_id": policyId,
        "driver_id": driverId,
        "helper_id": helperId,
        "conductor_id": conductorId,
        "extra_seats": extraSeats,
        "status": status,
        "deleted_status": deletedStatus,
        "trip_status": tripStatus,
        "status_remark": statusRemark,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "punch_out": punchOut,
        "punch_in": punchIn,
      };
}
