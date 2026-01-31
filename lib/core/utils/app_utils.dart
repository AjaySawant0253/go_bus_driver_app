import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication, // or inAppWebView
  )) {
    throw 'Could not launch $url';
  }
}


Future<void> openMapLink(String mapLink) async {
  try {
    // Check if the link is a valid URL
    final uri = Uri.parse(mapLink);
    
    // Ensure it's a valid URL (has scheme)
    if (!uri.hasScheme) {
      // Add https scheme if missing
      final fullUrl = 'https://$mapLink';
      // Launch the URL
      launchUrl(Uri.parse(fullUrl));
    } else {
      // Launch the URL directly
      launchUrl(uri);
    }
  } catch (e) {
    // Handle invalid URL
    print('Invalid map link: $mapLink');
    // You can show a toast or snackbar here
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Invalid map link')),
    // );
  }
}