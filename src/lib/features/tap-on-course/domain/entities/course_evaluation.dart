class CourseEvaluation {
  final String id;
  final String name;
  final String status;      // 'active' | 'closed'
  final String visibility;  // 'public' | 'private'
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
