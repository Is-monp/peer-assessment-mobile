import '../models/evaluation_model.dart';
import '../models/course_model.dart';

abstract class HomeStudentDataSource {
  Future<List<EvaluationModel>> getActiveEvaluations(String studentEmail);
  Future<List<CourseModel>> getEnrolledCourses(String studentEmail);
}
