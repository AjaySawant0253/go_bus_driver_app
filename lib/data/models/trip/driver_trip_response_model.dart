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
  final String? extraSeats;
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
  final Bus? bus;
  final Route? route;

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
    this.extraSeats,
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
    this.bus,
    this.route,
  });

  factory DriverTrip.fromJson(Map<String, dynamic> json) {
    return DriverTrip(
      id: json['id']?.toString() ?? '',
      routeId: json['route_id']?.toString() ?? '',
      tripStartDate: json['trip_start_date']?.toString() ?? '',
      tripStartTime: json['trip_start_time']?.toString() ?? '',
      tripEndDate: json['trip_end_date']?.toString() ?? '',
      tripEndTime: json['trip_end_time']?.toString() ?? '',
      busId: json['bus_id']?.toString() ?? '',
      policyId: json['policy_id']?.toString() ?? '',
      driverId: json['driver_id']?.toString() ?? '',
      helperId: json['helper_id']?.toString(),
      conductorId: json['conductor_id']?.toString(),
      extraSeats: json['extra_seats']?.toString(),
      status: json['status']?.toString() ?? '',
      deletedStatus: json['deleted_status']?.toString() ?? '',
      tripStatus: json['trip_status']?.toString() ?? '',
      statusRemark: json['status_remark']?.toString(),
      createdBy: json['created_by']?.toString() ?? '',
      updatedBy: json['updated_by']?.toString(),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      punchIn: json['punch_in']?.toString(),
      punchOut: json['punch_out']?.toString(),
      bus: json['bus'] != null ? Bus.fromJson(json['bus']) : null,
      route: json['route'] != null ? Route.fromJson(json['route']) : null,
    );
  }
}

class Route {
  final String id;
  final String startFrom;
  final String endAt;
  final String totalKms;
  final String duration;
  final String status;
  final String tripDays;

  Route({
    required this.id,
    required this.startFrom,
    required this.endAt,
    required this.totalKms,
    required this.duration,
    required this.status,
    required this.tripDays,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: json['id']?.toString() ?? '',
      startFrom: json['start_from']?.toString() ?? '',
      endAt: json['end_at']?.toString() ?? '',
      totalKms: json['total_kms']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      tripDays: json['trip_days']?.toString() ?? '',
    );
  }
}

class Bus {
  final String id;
  final String busName;
  final String busCompany;
  final String busModel;
  final String registrationNumber;
  final String busType;
  final String travelOutState;
  final String busAverage;
  final String totalLuggageCapacity;
  final String? notes;
  final String status;
  final String deletedStatus;
  final String? statusRemark;
  final String? deletedAt;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Bus({
    required this.id,
    required this.busName,
    required this.busCompany,
    required this.busModel,
    required this.registrationNumber,
    required this.busType,
    required this.travelOutState,
    required this.busAverage,
    required this.totalLuggageCapacity,
    this.notes,
    required this.status,
    required this.deletedStatus,
    this.statusRemark,
    this.deletedAt,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id']?.toString() ?? '',
      busName: json['bus_name']?.toString() ?? '',
      busCompany: json['bus_company']?.toString() ?? '',
      busModel: json['bus_model']?.toString() ?? '',
      registrationNumber: json['registration_number']?.toString() ?? '',
      busType: json['bus_type']?.toString() ?? '',
      travelOutState: json['travel_out_state']?.toString() ?? '',
      busAverage: json['bus_average']?.toString() ?? '',
      totalLuggageCapacity: json['total_luggage_capacity']?.toString() ?? '',
      notes: json['notes']?.toString(),
      status: json['status']?.toString() ?? '',
      deletedStatus: json['deleted_status']?.toString() ?? '',
      statusRemark: json['status_remark']?.toString(),
      deletedAt: json['deleted_at']?.toString(),
      createdBy: json['created_by']?.toString() ?? '',
      updatedBy: json['updated_by']?.toString(),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}
