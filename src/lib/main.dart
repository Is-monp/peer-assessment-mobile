import 'package:flutter/material.dart';
import 'package:src/features/auth/presentation/pages/signup_page.dart';
import 'package:src/features/home/presentation/pages/home_page.dart';
import 'package:src/features/auth/presentation/pages/login_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Evaluo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signup', page: () => const SignupPage()),
        // Aquí puedes agregar más rutas si es necesario
      ],
    );
  }
}
