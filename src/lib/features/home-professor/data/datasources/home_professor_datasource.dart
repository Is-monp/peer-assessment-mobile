import '../models/course_model.dart';

abstract class HomeProfessorDataSource {

  Future<List<CourseModel>> getAssignedCourses(String professorId);

}

class HomeProfessorDataSourceMock implements HomeProfessorDataSource {

  @override
  Future<List<CourseModel>> getAssignedCourses(String professorId) async {

    return [

      CourseModel(
        id: "1",
        code: "COMP-2201",
        name: "Software design",
        period: "2026-10",
        studentsCount: 30,
        activeEvaluations: 2,
      ),

      CourseModel(
        id: "2",
        code: "ISTI-3401",
        name: "Data structures",
        period: "2026-10",
        studentsCount: 36,
        activeEvaluations: 3,
      ),

    ];
  }
}