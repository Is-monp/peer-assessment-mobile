import 'package:get/get.dart';
import '../../domain/entities/course.dart';
import '../../domain/usecases/get_assigned_courses.dart';

class HomeProfessorController extends GetxController {

  final GetAssignedCourses getAssignedCourses;

  HomeProfessorController({
    required this.getAssignedCourses
  });

  final RxString professorName = "Josh Doe".obs;

  final RxList<Course> courses = <Course>[].obs;

  final RxInt coursesCount = 0.obs;
  final RxInt studentsCount = 0.obs;
  final RxInt activeEvaluations = 0.obs;

  String get professorInitials {
    final parts = professorName.value.split(" ");

    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }

    return professorName.value[0].toUpperCase();
  }

  @override
  void onInit() {
    super.onInit();
    loadCourses();
  }

  Future<void> loadCourses() async {

    final result = await getAssignedCourses("prof-1");

    courses.assignAll(result);

    coursesCount.value = courses.length;

    studentsCount.value =
        courses.fold(0, (sum, c) => sum + c.studentsCount);

    activeEvaluations.value =
        courses.fold(0, (sum, c) => sum + c.activeEvaluations);
  }

  void navigateToCourse(Course course) {
    Get.toNamed('/course-detail', arguments: course);
  }

}