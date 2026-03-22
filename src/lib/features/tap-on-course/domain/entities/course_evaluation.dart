enum CourseEvaluationStatus { active, closed }

enum CourseEvaluationVisibility { public, private }

class CourseEvaluation {
  final String id;
  final String name;
  final CourseEvaluationStatus status;
  final CourseEvaluationVisibility visibility;
  final int durationMinutes;
  final int respondedCount;

  const CourseEvaluation({
    required this.id,
    required this.name,
    required this.status,
    required this.visibility,
    required this.durationMinutes,
    required this.respondedCount,
  });
}
