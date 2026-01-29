class TripRoutesResponse {
  final bool status;
  final String message;
  final List<TripRoute> data;

  TripRoutesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TripRoutesResponse.fromJson(Map<String, dynamic> json) {
    return TripRoutesResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => TripRoute.fromJson(e))
          .toList(),
    );
  }
}

class TripRoute {
  final String routeId;
  final String? routeName;
  final List<PickupPoint> pickupPoints;
  final List<RestPoint> restPoints;
  final List<DropPoint> dropPoints;

  TripRoute({
    required this.routeId,
    this.routeName,
    required this.pickupPoints,
    required this.restPoints,
    required this.dropPoints,
  });

  factory TripRoute.fromJson(Map<String, dynamic> json) {
    return TripRoute(
      routeId: json['route_id'] ?? '',
      routeName: json['route_name'],
      pickupPoints: (json['pickup_points'] as List<dynamic>? ?? [])
          .map((e) => PickupPoint.fromJson(e))
          .toList(),
      restPoints: (json['rest_points'] as List<dynamic>? ?? [])
          .map((e) => RestPoint.fromJson(e))
          .toList(),
      dropPoints: (json['drop_points'] as List<dynamic>? ?? [])
          .map((e) => DropPoint.fromJson(e))
          .toList(),
    );
  }
}

class PickupPoint {
  final String id;
  final String stopName;
  final String address;
  final String mapLink;
  final int sequenceNo;
  final int dayCount;
  final DateTime? arrival;

  PickupPoint({
    required this.id,
    required this.stopName,
    required this.address,
    required this.mapLink,
    required this.sequenceNo,
    required this.dayCount,
    required this.arrival,
  });

  factory PickupPoint.fromJson(Map<String, dynamic> json) {
    return PickupPoint(
      id: json['id'] ?? '',
      stopName: json['stop_name'] ?? '',
      address: json['address'] ?? '',
      mapLink: json['map_link'] ?? '',
      sequenceNo: int.tryParse(json['sequence_no']?.toString() ?? '0') ?? 0,
      dayCount: int.tryParse(json['day_count']?.toString() ?? '0') ?? 0,
      arrival: json['arrival'] != null
          ? DateTime.tryParse(json['arrival'])
          : null,
    );
  }
}

class RestPoint {
  final String id;
  final String stopName;
  final String address;
  final String mapLink;
  final int sequenceNo;
  final int haltTime;
  final int dayCount;
  final DateTime? arrival;

  RestPoint({
    required this.id,
    required this.stopName,
    required this.address,
    required this.mapLink,
    required this.sequenceNo,
    required this.haltTime,
    required this.dayCount,
    required this.arrival,
  });

  factory RestPoint.fromJson(Map<String, dynamic> json) {
    return RestPoint(
      id: json['id'] ?? '',
      stopName: json['stop_name'] ?? '',
      address: json['address'] ?? '',
      mapLink: json['map_link'] ?? '',
      sequenceNo: int.tryParse(json['sequence_no']?.toString() ?? '0') ?? 0,
      haltTime: int.tryParse(json['halt_time']?.toString() ?? '0') ?? 0,
      dayCount: int.tryParse(json['day_count']?.toString() ?? '0') ?? 0,
      arrival: json['arrival'] != null
          ? DateTime.tryParse(json['arrival'])
          : null,
    );
  }
}

class DropPoint {
  final String id;
  final String stopName;
  final String address;
  final String mapLink;
  final int sequenceNo;
  final int dayCount;
  final DateTime? arrival;

  DropPoint({
    required this.id,
    required this.stopName,
    required this.address,
    required this.mapLink,
    required this.sequenceNo,
    required this.dayCount,
    required this.arrival,
  });

  factory DropPoint.fromJson(Map<String, dynamic> json) {
    return DropPoint(
      id: json['id'] ?? '',
      stopName: json['stop_name'] ?? '',
      address: json['address'] ?? '',
      mapLink: json['map_link'] ?? '',
      sequenceNo: int.tryParse(json['sequence_no']?.toString() ?? '0') ?? 0,
      dayCount: int.tryParse(json['day_count']?.toString() ?? '0') ?? 0,
      arrival: json['arrival'] != null
          ? DateTime.tryParse(json['arrival'])
          : null,
    );
  }
}
