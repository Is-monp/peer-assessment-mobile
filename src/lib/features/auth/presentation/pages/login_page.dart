import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:src/features/auth/data/models/UserController.dart';
import 'package:src/features/auth/presentation/widgets/text_box.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = UserController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
            child: Container(
              color: Colors.black.withValues(
                alpha: 0.5,
              ), // opcional para oscurecer
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 450,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: GoogleFonts.madimiOne(
                        fontSize: 50,
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
                    SizedBox(height: 20),

                    TextBox(hintText: 'Email', controller: emailController),
                    SizedBox(height: 20),
                    TextBox(
                      hintText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                    ),

                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withValues(alpha: 0.7),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          userController.testLogin(
                            "Test User",
                            emailController.text,
                            passwordController.text,
                          );
                        },
                        child: Text(
                          'Test Login',
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
