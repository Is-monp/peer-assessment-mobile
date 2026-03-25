import 'package:src/features/home-professor/domain/entities/course.dart';

import '../models/course_model.dart';

abstract class HomeProfessorDataSource {
  Future<List<Course>> getAssignedCourses(String professorId);
}
