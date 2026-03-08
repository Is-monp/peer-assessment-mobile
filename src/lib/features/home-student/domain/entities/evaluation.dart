enum EvaluationStatus { open, closed, pending }

class Evaluation {
  final String id;
  final String courseCode;
  final String title;
  final String courseName;
  final EvaluationStatus status;
  final String timeRemaining;

  const Evaluation({
    required this.id,
    required this.courseCode,
    required this.title,
    required this.courseName,
    required this.status,
    required this.timeRemaining,
  });
}
