import 'package:get/get.dart';
import 'package:src/features/auth/presentation/viewmodels/user_controller.dart';
import '../../domain/entities/evaluation.dart';
import '../../domain/entities/course.dart';
import '../../domain/usecases/get_active_evaluations.dart';
import '../../domain/usecases/get_enrolled_courses.dart';
import 'package:src/core/navigation/navigation_service.dart'; //Navegacion centralizada

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
    final evals = await getActiveEvaluations('student-1');
    final courseList = await getEnrolledCourses('student-1');
    evaluations.assignAll(evals);
    courses.assignAll(courseList);
    isLoading.value = false;
  }

<<<<<<< Updated upstream
  //not implemented yet butttt to have a glimpse of how it would work
  // implementar cuando exista la página de evaluación
  void navigateToEvaluation(Evaluation evaluation) {
  //   NavigationService.toEvaluation(evaluation);
=======
  // not implemented yet — páginas pendientes de crear
  void navigateToEvaluation(Evaluation evaluation) {
    // Get.to(() => const EvaluationPage(), arguments: evaluation);
>>>>>>> Stashed changes
  }

  // implementar cuando exista la página de curso para estudiante
  void navigateToCourse(Course course) {
<<<<<<< Updated upstream
  //   NavigationService.toCourse(course);
=======
    // Get.to(() => const CourseStudentPage(), arguments: course);
>>>>>>> Stashed changes
  }
}
