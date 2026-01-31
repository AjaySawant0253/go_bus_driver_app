import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_bus_driver_app/core/secure/secure_storage_service.dart';
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
  final SecureStorageService _storageService = SecureStorageService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                context.goNamed(RoutePaths.home);
              }

              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        /// ---------------- LOGO ----------------
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppStrings.loginLogo,
                              width: 150,
                              height: 120,
                            ),
                            const SizedBox(width: 12),
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
                        CustomTextFormField(
                          controller: emailController,
                          labelText: "Email / Contact no",
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          hasBorder: false,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Email or contact number is required";
                            }
                        
                            final input = value.trim();
                        
                            // Email regex
                            final emailRegex =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        
                            // Mobile regex (10 digits)
                            final phoneRegex = RegExp(r'^[0-9]{10}$');
                        
                            if (!emailRegex.hasMatch(input) &&
                                !phoneRegex.hasMatch(input)) {
                              return "Enter a valid email or 10-digit contact number";
                            }
                        
                            return null;
                          },
                        ),

                        const SizedBox(height: 28),

                        /// ---------------- PASSWORD ----------------
                        CustomTextFormField(
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 40),

                        /// ---------------- SIGN IN BUTTON ----------------
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: state is LoginLoading
                                ? null
                                : () async {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    final token =
                                        await _storageService.getFcmToken();
                                    context.read<LoginBloc>().add(
                                          LoginButtonPressed(
                                            userDetails:
                                                emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                            fcmToken: token ?? "",
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
