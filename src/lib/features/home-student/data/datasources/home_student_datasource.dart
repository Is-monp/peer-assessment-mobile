import '../models/evaluation_model.dart';
import '../models/course_model.dart';
import '../../domain/entities/evaluation.dart';

abstract class HomeStudentDataSource {
  Future<List<EvaluationModel>> getActiveEvaluations(String studentId);
  Future<List<CourseModel>> getEnrolledCourses(String studentId);
}

class HomeStudentDataSourceMock implements HomeStudentDataSource {
  @override
  Future<List<EvaluationModel>> getActiveEvaluations(String studentId) async {
    return const [
      EvaluationModel(
        id: '1',
        courseCode: 'COMP-3401',
        title: 'Algorithm Challenge review',
        courseName: 'Data structures',
        status: EvaluationStatus.open,
        timeRemaining: '28:12',
      ),
      EvaluationModel(
        id: '2',
        courseCode: 'COMP-2201',
        title: 'Sprint 2 Peer review',
        courseName: 'Software design',
        status: EvaluationStatus.open,
        timeRemaining: '18:22',
      ),
    ];
  }

  @override
  Future<List<CourseModel>> getEnrolledCourses(String studentId) async {
    return const [
      CourseModel(
        id: '1',
        code: 'COMP-2201',
        name: 'Software design',
        period: '2026-10',
        activeEvaluations: 1,
      ),
      CourseModel(
        id: '2',
        code: 'COMP-3401',
        name: 'Data structures',
        period: '2026-10',
        activeEvaluations: 1,
      ),
      CourseModel(
        id: '3',
        code: 'COMP-3701',
        name: 'math structures',
        period: '2026-10',
        activeEvaluations: 0,
      ),
    ];
  }
}
