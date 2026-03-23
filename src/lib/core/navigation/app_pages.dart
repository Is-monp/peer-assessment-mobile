// lib/core/navigation/app_pages.dart

import 'package:get/get.dart';
import 'app_routes.dart';

import 'package:src/features/Splash-Screen/presentation/pages/home_page.dart';
import 'package:src/features/auth/presentation/pages/login_page.dart';
import 'package:src/features/auth/presentation/pages/signup_page.dart';
import 'package:src/features/home-student/presentation/pages/home_student_page.dart';
import 'package:src/features/home-student/presentation/state_management/home_student_binding.dart';
import 'package:src/features/home-professor/presentation/pages/home_professor_page.dart';
import 'package:src/features/home-professor/presentation/state_management/home_professor_binding.dart';
import 'package:src/features/tap-on-course/presentation/pages/tap_course_page.dart';
import 'package:src/features/tap-on-course/presentation/state_management/tap_course_binding.dart';

abstract class AppPages {
  static const String initial = AppRoutes.splash;

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupPage(),
    ),
    GetPage(
      name: AppRoutes.homeStudent,
      page: () => const HomeStudentPage(),
      binding: HomeStudentBinding(),
    ),
    GetPage(
      name: AppRoutes.homeProfessor,
      page: () => const HomeProfessorPage(),
      binding: HomeProfessorBinding(),
    ),
    GetPage(
      name: AppRoutes.courseDetail,
      page: () => const TapCoursePage(),
      binding: TapCourseBinding(),
    ),
  ];
}