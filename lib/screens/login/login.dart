import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/core/widgets/custom_text_form_field.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';
import 'package:go_bus_driver_app/core/constants/app_strings.dart';
import 'package:go_bus_driver_app/data/bloc/login/login_bloc.dart';
import 'package:go_bus_driver_app/data/bloc/login/login_event.dart';
import 'package:go_bus_driver_app/data/bloc/login/login_state.dart';
import 'package:go_bus_driver_app/routes/route_paths.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                /// ✅ Navigate to Home
                context.goNamed(RoutePaths.home);
              }

              if (state is LoginFailure) {
                /// ❌ Show error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width * 0.12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      /// ---------------- LOGO ----------------
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              AppStrings.startupLogo,
                              width: 35,
                              height: 35,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "GoBus",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: size.width * 0.075,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Travel made simple",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: size.width * 0.035,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      /// ---------------- IMAGE ----------------
                      Center(
                        child: Image.asset(
                          AppStrings.signinImg,
                          width: size.width * 0.75,
                        ),
                      ),

                      const SizedBox(height: 45),

                      /// ---------------- EMAIL ----------------
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: CustomTextFormField(
                          controller: emailController,
                          labelText: "Email / Contact no",
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          hasBorder: false,
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// ---------------- PASSWORD ----------------
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: CustomTextFormField(
                          controller: passwordController,
                          labelText: "Password",
                          obscureText: !showPassword,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() => showPassword = !showPassword);
                            },
                            child: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.primary,
                            ),
                          ),
                          hasBorder: false,
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// ---------------- SIGN IN BUTTON ----------------
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: state is LoginLoading
                              ? null
                              : () {
                                  context.read<LoginBloc>().add(
                                        LoginButtonPressed(
                                          userDetails:
                                              emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                          fcmToken: "",
                                          signatureId: "",
                                          lat: "",
                                          lng: "",
                                        ),
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: state is LoginLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
