class Course {
  final String id;
  final String code;
  final String name;
  final String period;
  final int studentsCount;
  final int activeEvaluations;

  Course({
    required this.id,
    required this.code,
    required this.name,
    required this.period,
    required this.studentsCount,
    required this.activeEvaluations,
  });
}