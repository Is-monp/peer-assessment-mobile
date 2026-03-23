
import 'package:get/get.dart';
import 'app_routes.dart';
import 'package:src/features/home-professor/domain/entities/course.dart';

class NavigationService {

  static void toHomeStudent() {
    Get.toNamed(AppRoutes.homeStudent);
  }

  static void toHomeProfessor() {
    Get.toNamed(AppRoutes.homeProfessor);
  }

  static void toCourseDetail(Course course) {
    Get.toNamed(AppRoutes.courseDetail, arguments: course);
  }

  static void toLogin() {
    Get.toNamed(AppRoutes.login);
  }

  static void toSignup() {
    Get.toNamed(AppRoutes.signup);
  }

  static void toSplash() {
    Get.offAllNamed(AppRoutes.splash);
  }
}