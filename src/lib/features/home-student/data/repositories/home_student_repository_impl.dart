//this is supposed to be a middle man

import '../models/evaluation_model.dart';
import '../models/course_model.dart';
import '../../domain/repositories/home_student_repository.dart';
import '../datasources/home_student_datasource.dart';

class HomeStudentRepositoryImpl implements HomeStudentRepository {
  final HomeStudentDataSource dataSource;

  HomeStudentRepositoryImpl(this.dataSource);

  @override
  Future<List<EvaluationModel>> getActiveEvaluations(String studentId) {
    return dataSource.getActiveEvaluations(studentId);
  }

  @override
  Future<List<CourseModel>> getEnrolledCourses(String studentId) {
    return dataSource.getEnrolledCourses(studentId);
  }
}
