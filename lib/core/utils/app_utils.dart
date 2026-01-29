import 'package:intl/intl.dart';

String formatTime(String? time) {
  if (time == null || time.isEmpty) return "Pending";

  try {
    // Case 1: Full datetime → "2026-01-21 05:56:13"
    if (time.contains(' ')) {
      final dt = DateTime.parse(time);
      return DateFormat('h:mm a').format(dt);
    }

    // Case 2: Time with seconds → "17:24:00"
    if (time.split(':').length == 3) {
      final parsed = DateFormat("HH:mm:ss").parse(time);
      return DateFormat('h:mm a').format(parsed);
    }

    // Case 3: Time without seconds → "17:24"
    final parsed = DateFormat("HH:mm").parse(time);
    return DateFormat('h:mm a').format(parsed);
  } catch (e) {
    return time; // fallback (never crash UI)
  }
}
