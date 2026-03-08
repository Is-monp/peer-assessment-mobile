import 'package:flutter/material.dart';
import 'package:src/features/auth/data/models/UserController.dart';
import 'package:src/features/auth/presentation/pages/signup_page.dart';
import 'package:src/features/Splash-Screen/presentation/pages/home_page.dart';
import 'package:src/features/auth/presentation/pages/login_page.dart';
import 'package:src/features/home-student/presentation/pages/home_student_page.dart';
import 'package:src/features/home-student/presentation/state_management/home_student_binding.dart';
import 'package:get/get.dart';

void main() {
  // register UserController as a permanent global dependency so it persists across all routes and can be retrieved with Get.find<UserController>()
  Get.put(UserController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Evaluo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signin', page: () => const SignupPage()),
        GetPage(
          name: '/home-student',
          page: () => const HomeStudentPage(),
          binding: HomeStudentBinding(),
        ),
      ],
    );
  }
}
