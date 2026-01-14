import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/core/widgets/app_header.dart';
import 'package:go_bus_driver_app/data/models/driver_trip_response_model.dart';
import 'package:go_bus_driver_app/screens/Profile/profile.dart';
import 'package:go_bus_driver_app/screens/home/tabs/completed_tab.dart';
import 'package:go_bus_driver_app/screens/home/tabs/ongoing_tab.dart';
import 'package:go_bus_driver_app/screens/home/tabs/upcoming_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentSectionIndex = 0;

  DriverTripsResponse? tripsData;

  /// DEMO JSON
  final demoJson = <String, dynamic>{
    "status": true,
    "message": "Driver Trips Fetched Successfully",
    "data": {
      "upcoming": [
        {
          "id": "2934f2fb-933d-49c2-a948-9f093f6ff981",
          "route_id": "34f1f655-a743-4c0e-b0a6-2a2e495c1e38",
          "trip_start_date": "2026-01-08",
          "trip_start_time": "16:40:00",
          "trip_end_date": "2026-01-09",
          "trip_end_time": "20:44:00",
          "bus_id": "a0486494-2467-43e2-ad16-0afcffb55d0e",
          "policy_id": "d4c6db64-d2b9-4ab2-884c-18b36c726e00",
          "driver_id": "897dc996-57fd-4b17-8ef0-1ed33884caf1",
          "helper_id": null,
          "conductor_id": null,
          "extra_seats": 10,
          "status": "Active",
          "deleted_status": "0",
          "trip_status": "Scheduled",
          "status_remark": null,
          "created_by": "78123aad-d7dc-42a3-bdab-586d920154a7",
          "updated_by": null,
          "created_at": "2025-11-15T11:13:35.000000Z",
          "updated_at": "2025-11-15T11:13:35.000000Z",
          "punch_out": null,
          "punch_in": null
        }
      ],
      "goingOn": [
        {
          "id": "1111f2fb-933d-49c2-a948-9f093f6ff981",
          "route_id": "99f1f655-a743-4c0e-b0a6-2a2e495c1e38",
          "trip_start_date": "2025-12-11",
          "trip_start_time": "10:30:00",
          "trip_end_date": null,
          "trip_end_time": null,
          "bus_id": " MH12 DE 1433",
          "policy_id": "aabcdb64-d2b9-4ab2-884c-18b36c726e00",
          "driver_id": "897dc996-57fd-4b17-8ef0-1ed33884caf1",
          "helper_id": null,
          "conductor_id": null,
          "extra_seats": 5,
          "status": "Active",
          "deleted_status": "0",
          "trip_status": "OnGoing",
          "status_remark": "Driver started the trip",
          "created_by": "78123aad-d7dc-42a3-bdab-586d920154a7",
          "updated_by": "78123aad-d7dc-42a3-bdab-586d920154a7",
          "created_at": "2025-12-11T07:13:35.000000Z",
          "updated_at": "2025-12-11T07:13:35.000000Z",
          "punch_out": null,
          "punch_in": "2025-12-11T07:10:00.000000Z"
        }
      ],
      "completed": [
        {
          "id": "a53a1df7-4c03-4e3d-a830-be6b07c57fdf",
          "route_id": "72153537-131c-4755-8f6c-15f80e487a9e",
          "trip_start_date": "2025-11-22",
          "trip_start_time": "18:00:00",
          "trip_end_date": "2025-11-23",
          "trip_end_time": "05:14:00",
          "bus_id": "MH12 DE 1433",
          "policy_id": "465b671d-85be-45b7-842e-98ee7726c4e2",
          "driver_id": "897dc996-57fd-4b17-8ef0-1ed33884caf1",
          "helper_id": null,
          "conductor_id": null,
          "extra_seats": 10,
          "status": "Active",
          "deleted_status": "1",
          "trip_status": "Completed",
          "status_remark": null,
          "created_by": "78123aad-d7dc-42a3-bdab-586d920154a7",
          "updated_by": null,
          "created_at": "2025-11-14T10:44:11.000000Z",
          "updated_at": "2025-11-15T07:07:51.000000Z",
          "punch_out": "2025-11-23T05:30:00.000000Z",
          "punch_in": "2025-11-22T17:40:00.000000Z"
        },
        {
          "id": "a53a1df7-4c03-4e3d-a830-be6b07c57fdf",
          "route_id": "72153537-131c-4755-8f6c-15f80e487a9e",
          "trip_start_date": "2025-11-22",
          "trip_start_time": "18:00:00",
          "trip_end_date": "2025-11-23",
          "trip_end_time": "05:14:00",
          "bus_id": "MH12 DE 1433",
          "policy_id": "465b671d-85be-45b7-842e-98ee7726c4e2",
          "driver_id": "897dc996-57fd-4b17-8ef0-1ed33884caf1",
          "helper_id": null,
          "conductor_id": null,
          "extra_seats": 10,
          "status": "Active",
          "deleted_status": "1",
          "trip_status": "Completed",
          "status_remark": null,
          "created_by": "78123aad-d7dc-42a3-bdab-586d920154a7",
          "updated_by": null,
          "created_at": "2025-11-14T10:44:11.000000Z",
          "updated_at": "2025-11-15T07:07:51.000000Z",
          "punch_out": "2025-11-23T05:30:00.000000Z",
          "punch_in": "2025-11-22T17:40:00.000000Z"
        },
        {
          "id": "a53a1df7-4c03-4e3d-a830-be6b07c57fdf",
          "route_id": "72153537-131c-4755-8f6c-15f80e487a9e",
          "trip_start_date": "2025-11-22",
          "trip_start_time": "18:00:00",
          "trip_end_date": "2025-11-23",
          "trip_end_time": "05:14:00",
          "bus_id": "MH12 DE 1433",
          "policy_id": "465b671d-85be-45b7-842e-98ee7726c4e2",
          "driver_id": "897dc996-57fd-4b17-8ef0-1ed33884caf1",
          "helper_id": null,
          "conductor_id": null,
          "extra_seats": 10,
          "status": "Active",
          "deleted_status": "1",
          "trip_status": "Completed",
          "status_remark": null,
          "created_by": "78123aad-d7dc-42a3-bdab-586d920154a7",
          "updated_by": null,
          "created_at": "2025-11-14T10:44:11.000000Z",
          "updated_at": "2025-11-15T07:07:51.000000Z",
          "punch_out": "2025-11-23T05:30:00.000000Z",
          "punch_in": "2025-11-22T17:40:00.000000Z"
        }
      ]
    }
  };

  @override
  void initState() {
    super.initState();
    fetchTrips();
  }

  /// FIXED: Proper JSON parsing
  Future<void> fetchTrips() async {
    final parsed = DriverTripsResponse.fromJson(demoJson);
    tripsData = parsed;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _getCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color(0xFFFF6A00),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _getCurrentScreen() {
    if (_selectedIndex == 0) {
      // Home/Schedule Screen
      return _buildHomeScreen();
    } else {
      // Profile Screen
      return ProfileScreen();
    }
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        // Header
        SafeArea(
          child: GoBusHeader(showBackButton: false),
        ),
        const SizedBox(height: 5),

        // SECTION TABS
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              _topTabButton("Upcoming", 0),
              _topTabButton("Ongoing", 1),
              _topTabButton("Completed", 2),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Tab Content
        Expanded(child: _getCurrentTab()),
      ],
    );
  }

  Widget _topTabButton(String title, int index) {
    bool isSelected = _currentSectionIndex == index;
    bool isFirstTab = index == 0;
    bool isLastTab = index == 2;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentSectionIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFF6A00) : Colors.grey.shade300,
            borderRadius: BorderRadius.only(
              topLeft: isFirstTab ? const Radius.circular(6) : Radius.zero,
              bottomLeft: isFirstTab ? const Radius.circular(6) : Radius.zero,
              topRight: isLastTab ? const Radius.circular(6) : Radius.zero,
              bottomRight: isLastTab ? const Radius.circular(6) : Radius.zero,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getCurrentTab() {
    if (tripsData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    switch (_currentSectionIndex) {
      case 0:
        return UpcomingTab(trips: tripsData!);
      case 1:
        return OngoingTab(trips: tripsData!);
      case 2:
        return CompletedTab(trips: tripsData!);
      default:
        return UpcomingTab(trips: tripsData!);
    }
  }
}