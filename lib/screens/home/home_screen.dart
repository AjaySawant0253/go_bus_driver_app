import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/core/di/injection_container.dart';
import 'package:go_bus_driver_app/core/widgets/app_header.dart';
import 'package:go_bus_driver_app/data/bloc/logout/logout_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/trip/trip_state.dart';
import 'package:go_bus_driver_app/data/models/trip/driver_trip_response_model.dart';
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
      return _buildHomeScreen();
    } else {
       return BlocProvider(
      create: (_) => sl<LogoutBloc>(),
      child: const ProfileScreen(),
    );
    }
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        SafeArea(
          child: GoBusHeader(showBackButton: false),
        ),
        const SizedBox(height: 5),

        /// TOP SECTION TABS
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

        /// DATA FROM API (Bloc)
        Expanded(
          child: BlocBuilder<TripBloc, TripState>(
            builder: (context, state) {
              if (state is TripLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is TripError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state is TripLoaded) {
                return _getCurrentTab(state.response);
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _topTabButton(String title, int index) {
    final bool isSelected = _currentSectionIndex == index;
    final bool isFirstTab = index == 0;
    final bool isLastTab = index == 2;

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

  Widget _getCurrentTab(DriverTripsResponse tripsData) {
    switch (_currentSectionIndex) {
      case 0:
        return UpcomingTab();
      case 1:
        return OngoingTab();
      case 2:
        return CompletedTab();
      default:
        return UpcomingTab();
    }
  }
}
