import 'package:get/get.dart';
import '../../data/datasources/home_student_datasource.dart';
import '../../data/repositories/home_student_repository_impl.dart';
import '../../domain/repositories/home_student_repository.dart';
import '../../domain/usecases/get_active_evaluations.dart';
import '../../domain/usecases/get_enrolled_courses.dart';
import 'home_student_controller.dart';

class HomeStudentBinding extends Bindings {
  @override
  void dependencies() { //lazyput basically means it wont be created until the page actually needs them
    Get.lazyPut<HomeStudentDataSource>(() => HomeStudentDataSourceMock());
    Get.lazyPut<HomeStudentRepository>(
      () => HomeStudentRepositoryImpl(Get.find()),
    );
    //not implements yet butttt to have a glimpse of how it would work
    Get.lazyPut(() => GetActiveEvaluations(Get.find()));
    Get.lazyPut(() => GetEnrolledCourses(Get.find()));
    Get.lazyPut(
      () => HomeStudentController(
        getActiveEvaluations: Get.find(), //creating controller with use cases
        getEnrolledCourses: Get.find(),
      ),
    );
  }
}
