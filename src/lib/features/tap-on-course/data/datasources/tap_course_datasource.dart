import '../models/course_evaluation_model.dart';
import '../models/group_category_model.dart';
import '../parsers/csv_group_parser.dart';

abstract class TapCourseDatasource {
  Future<List<CourseEvaluationModel>> getCourseEvaluations(String courseId);
  Future<List<GroupCategoryModel>> getCourseGroups(String courseId);
  Future<List<GroupCategoryModel>> importGroupsFromCsv(String csvContent, String courseId); // 👈
}

class TapCourseDatasourceMock implements TapCourseDatasource {
  final CsvGroupParser csvParser = CsvGroupParser();

  @override
  Future<List<CourseEvaluationModel>> getCourseEvaluations(String courseId) async {
    return [
      const CourseEvaluationModel(
        id: 'eval-1',
        name: 'Sprint 1 Peer review',
        status: CourseEvaluationStatus.closed,
        visibility: CourseEvaluationVisibility.public,
        durationMinutes: 60,
        respondedCount: 20,
      ),
      const CourseEvaluationModel(
        id: 'eval-2',
        name: 'Sprint 2 Peer review',
        status: CourseEvaluationStatus.active,
        visibility: CourseEvaluationVisibility.public,
        durationMinutes: 60,
        respondedCount: 1,
      ),
    ];
  }

  @override
  Future<List<GroupCategoryModel>> getCourseGroups(String courseId) async {
    return [];
  }

  @override
  Future<List<GroupCategoryModel>> importGroupsFromCsv(String csvContent, String courseId) async {
    return csvParser.parse(csvContent); // ignora courseId, solo parsea localmente
  }
}