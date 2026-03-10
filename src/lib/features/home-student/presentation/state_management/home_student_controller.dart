import 'package:get/get.dart';
import 'package:src/features/auth/data/models/UserController.dart';
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
    studentName.value = Get.find<UserController>().userName;
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
//not implemented yet butttt to have a glimpse of how it would work
  void navigateToEvaluation(Evaluation evaluation) {
    Get.toNamed('/evaluation', arguments: evaluation);
  }

  void navigateToCourse(Course course) {
    Get.toNamed('/course', arguments: course);
  }
}
