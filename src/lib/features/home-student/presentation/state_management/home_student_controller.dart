import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:src/features/auth/presentation/viewmodels/user_controller.dart';
import 'package:src/features/tap-on-course/presentation/models/course_ui.dart';
import 'package:src/features/tap-on-course/presentation/state_management/tap_course_binding.dart';
import 'package:src/features/tap-on-course/presentation/pages/tap_course_page.dart';
import '../../domain/entities/evaluation.dart';
import '../../domain/entities/course.dart';
import '../../domain/usecases/get_active_evaluations.dart';
import '../../domain/usecases/get_enrolled_courses.dart';

class HomeStudentController extends GetxController {
  final GetActiveEvaluations getActiveEvaluations;
  final GetEnrolledCourses getEnrolledCourses;

  HomeStudentController({
    required this.getActiveEvaluations,
    required this.getEnrolledCourses,
  });

  final RxList<Evaluation> evaluations = <Evaluation>[].obs;
  final RxList<Course> courses = <Course>[].obs;
  final RxBool isLoading = true.obs;
  final RxString studentName = 'Theo James'.obs;

  String get studentInitials {
    final parts = studentName.value.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts[0][0].toUpperCase();
  }

  @override
  void onInit() {
    super.onInit();
    studentName.value =
        Get.find<UserController>().loggedUser?.name ?? "default user";
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading.value = true;

    final studentEmail = Get.find<UserController>().loggedUser?.email;
    if (studentEmail == null) {
      logError("student email is null");
      isLoading.value = false;
      return;
    }

    final evals = await getActiveEvaluations(studentEmail);
    final courseList = await getEnrolledCourses(studentEmail);
    evaluations.assignAll(evals);
    courses.assignAll(courseList);
    isLoading.value = false;
  }

  // not implemented yet — páginas pendientes de crear
  void navigateToEvaluation(Evaluation evaluation) {
    // Get.to(() => const EvaluationPage(), arguments: evaluation);
  }

  void navigateToCourse(Course course) {
    TapCourseBinding().dependencies();
    Get.to(
      () => const TapCoursePage(),
      arguments: CourseUI(
        id: course.id,
        code: course.code,
        name: course.name,
        period: course.period,
        studentsCount: 0,
        activeEvaluations: course.activeEvaluations,
      ),
    );
  }
}
