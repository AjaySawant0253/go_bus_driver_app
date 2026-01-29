import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/core/di/injection_container.dart';
import 'package:go_bus_driver_app/core/secure/secure_storage_service.dart';
import 'package:go_bus_driver_app/core/widgets/app_header.dart';
import 'package:go_bus_driver_app/data/bloc/logout/logout_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/logout/logout_event.dart';
import 'package:go_bus_driver_app/data/bloc/logout/logout_state.dart';
import 'package:go_bus_driver_app/routes/route_paths.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = '';
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
      employeeImage = prefs.getString('empImg') ?? '';
    });
  }

  void clearData() {
    final secureStorage = sl<SecureStorageService>();
    secureStorage.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is LogoutSuccess) {
          Navigator.pop(context);
          clearData();
          context.goNamed(RoutePaths.login);
        }

        if (state is LogoutFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GoBusHeader(showBackButton: false),
              const SizedBox(height: 40),

              /// Profile Image (NETWORK ONLY)
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: employeeImage.isNotEmpty
                    ? NetworkImage(
                        "https://test.newtrimurtitravels.com/$employeeImage",
                      )
                    : null,
                child: employeeImage.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.white,
                      )
                    : null,
              ),

              const SizedBox(height: 20),

              Text(
                fullName.isNotEmpty ? fullName : "User",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 40),

              buildMenuItem(
                icon: Icons.person_outline,
                title: "Personal Information",
                onTap: () {
                  context.push(RoutePaths.personalInfo);
                },
              ),

              // buildMenuItem(
              //   icon: Icons.help_outline,
              //   title: "Help",
              //   onTap: () {},
              // ),

              buildMenuItem(
                icon: Icons.logout,
                title: "Log Out",
                onTap: () {
                  context.read<LogoutBloc>().add(LogoutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, size: 26),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
