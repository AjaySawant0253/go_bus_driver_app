import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/core/constants/api_endpoints.dart';
import 'package:go_bus_driver_app/core/widgets/app_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  String fullName = '';
  String email = '';
  String gender = '';
  String contactNumber = '';
  String employeeImage = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('name') ?? '';
      email = prefs.getString('email') ?? '';
      gender = prefs.getString('gender') ?? '';
      contactNumber = prefs.getString('contact') ?? '';
      employeeImage = prefs.getString('empImg') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const GoBusHeader(showBackButton: true),

            const SizedBox(height: 28),

            /// Profile Image
            CircleAvatar(
              radius: 56,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: employeeImage.isNotEmpty
                  ? NetworkImage("${ApiEndpoints.baseUrl}/$employeeImage")
                  : null,
              child: employeeImage.isEmpty
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),

            const SizedBox(height: 16),

            const SizedBox(height: 32),

            /// Info Cards
            _infoTile("Name", fullName),
            _infoTile("Email", email),
            _genderTile(),
            _infoTile("Contact Number", contactNumber),
          ],
        ),
      ),
    );
  }

  /// Standard Info Tile
  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value.isNotEmpty ? value : "—",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Gender Tile (Man / Woman)
  Widget _genderTile() {
    final isMale = gender.toLowerCase() == 'male';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 120,
              child: Text(
                "Gender",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            Icon(
              isMale ? Icons.male : Icons.female,
              color: isMale ? Colors.blue : Colors.pink,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              isMale ? "Man" : "Woman",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
