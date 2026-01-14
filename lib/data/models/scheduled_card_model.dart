class ScheduleModel {
  final String fromCity;
  final String toCity;
  final String scheduleDate;
  final String busName;
  final String busNumber;
  final String startTime;
  final String endTime;
  final String duration;
   bool isPunchedIn;

  ScheduleModel({
    required this.fromCity,
    required this.toCity,
    required this.scheduleDate,
    required this.busName,
    required this.busNumber,
    required this.startTime,
    required this.endTime,
    required this.duration,
    this.isPunchedIn = false,
  });
}
