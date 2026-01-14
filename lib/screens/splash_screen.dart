import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';
import 'package:go_bus_driver_app/core/constants/app_strings.dart';
import 'package:go_bus_driver_app/routes/route_paths.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero, // Start at full screen
      end: const Offset(0, -1.5), // Slide completely up off-screen
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start animation after short delay
    Future.delayed(const Duration(milliseconds: 1100), () {
      _controller.forward();
    });

    // Navigate to next page after animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        context.goNamed(RoutePaths.login);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Blue splash background that slides up
            SlideTransition(
              position: _slideAnimation,
              child: Container(
                height: size.height,
                width: double.infinity,
                color: AppColors.primary, // GoBus Blue
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          24,
                        ), // Adds inner spacing around the image
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark, // Background color (optional)
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                0.15,
                              ), // Shadow color with transparency
                              spreadRadius: 2, // How far the shadow spreads
                              blurRadius: 8, // Softness of the shadow
                              offset: const Offset(
                                0,
                                4,
                              ), // Shadow position (x, y)
                            ),
                          ],
                        ),
                        child: Image.asset(
                          AppStrings.startupLogo,
                          width: size.width * 0.2,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        AppStrings.goBus,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        AppStrings.subTxt,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
