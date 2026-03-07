import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:src/features/Splash-Screen/presentation/widgets/button_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
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
                alpha: 0.2,
              ), // opcional para oscurecer
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// 🔹 Texto centrado verticalmente
                Expanded(
                  child: Center(
                    child: Text(
                      'Evaluo',
                      style: GoogleFonts.madimiOne(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                /// 🔹 Botones abajo
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ButtonHome(
                          onPressed: () {
                            Get.toNamed("/login");
                          },
                          text: 'Log in',
                        ),
                      ),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        child: ButtonHome(
                          onPressed: () {
                            Get.toNamed("/signin");
                          },
                          text: 'Sign in',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
