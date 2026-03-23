import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:src/features/auth/presentation/viewmodels/user_controller.dart';
import 'package:src/features/Splash-Screen/presentation/pages/home_page.dart';
import 'package:src/features/home-professor/presentation/pages/home_professor_page.dart';
import 'package:src/features/home-professor/presentation/state_management/home_professor_binding.dart';

class Central extends StatelessWidget {
  const Central({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();

    return Obx(() {
      if (!userController.isLogged) return const HomePage();

      HomeProfessorBinding().dependencies();
      return const HomeProfessorPage();
    });
  }
}