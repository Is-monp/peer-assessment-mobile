//this is supposed to be a middle man

import '../../domain/entities/evaluation.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/home_student_repository.dart';
import '../datasources/home_student_datasource.dart';

class HomeStudentRepositoryImpl implements HomeStudentRepository {
  final HomeStudentDataSource dataSource;

  HomeStudentRepositoryImpl(this.dataSource);

  @override
  Future<List<Evaluation>> getActiveEvaluations(String studentId) {
    return dataSource.getActiveEvaluations(studentId);
  }

  @override
  Future<List<Course>> getEnrolledCourses(String studentId) {
    return dataSource.getEnrolledCourses(studentId);
  }
}
