import '../../domain/entities/course_evaluation.dart';

enum CourseEvaluationStatus { active, closed }

enum CourseEvaluationVisibility { public, private }

class CourseEvaluationModel {
  final String id;
  final String name;
  final CourseEvaluationStatus status;
  final CourseEvaluationVisibility visibility;
  final int durationMinutes;
  final int respondedCount;

  const CourseEvaluationModel({
    required this.id,
    required this.name,
    required this.status,
    required this.visibility,
    required this.durationMinutes,
    required this.respondedCount,
  });

  CourseEvaluation toEntity() => CourseEvaluation(
        id: id,
        name: name,
        status: status.name,
        visibility: visibility.name,
        durationMinutes: durationMinutes,
        respondedCount: respondedCount,
      );
}
