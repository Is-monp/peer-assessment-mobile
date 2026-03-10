import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:src/features/auth/presentation/bloc/UserController.dart';
import 'package:src/features/auth/presentation/widgets/text_box.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = Get.find<UserController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _onLogin() {
    final success = userController.login(
      emailController.text.trim(),
      passwordController.text,
    );
    if (!success) {
      Get.snackbar(
        'Login failed',
        'Invalid email or password',
        backgroundColor: const Color(0xFF3A2016),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 50),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(color: Colors.black.withValues(alpha: 0.5)),
          ),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 450,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's get you signed in",
                      style: GoogleFonts.madimiOne(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Sign in to your account",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextBox(hintText: 'Email', controller: emailController),
                    const SizedBox(height: 20),
                    TextBox(
                      hintText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withValues(alpha: 0.7),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _onLogin,
                        child: Text(
                          'Log in',
                          style: GoogleFonts.madimiOne(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
