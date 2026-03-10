import '../../data/models/course_model.dart';
import '../../domain/repositories/home_professor_repository.dart';
import '../datasources/home_professor_datasource.dart';

class HomeProfessorRepositoryImpl implements HomeProfessorRepository {
  final HomeProfessorDataSource datasource;

  HomeProfessorRepositoryImpl(this.datasource);

  @override
  Future<List<CourseModel>> getAssignedCourses(String professorId) {
    return datasource.getAssignedCourses(professorId);
  }
}
