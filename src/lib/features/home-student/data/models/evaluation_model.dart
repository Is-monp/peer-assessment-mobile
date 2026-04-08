import '../../domain/entities/evaluation.dart';

class EvaluationModel extends Evaluation {
  const EvaluationModel({
    required super.id,
    required super.courseCode,
    required super.title,
    required super.courseName,
    required super.status,
    required super.timeRemaining,
  });

  factory EvaluationModel.fromDbJson(
    Map<String, dynamic> evalJson,
    Map<String, dynamic> courseJson,
  ) {
    final deadline = DateTime.parse(evalJson['deadline'] as String);
    return EvaluationModel(
      id: evalJson['_id'].toString(),
      courseCode: courseJson['code'] as String? ?? '---',
      title: evalJson['name'] as String,
      courseName: courseJson['name'] as String? ?? '---',
      status: EvaluationStatus.open,
      timeRemaining: _computeTimeRemaining(deadline),
    );
  }

  static String _computeTimeRemaining(DateTime deadline) {
    final diff = deadline.difference(DateTime.now());
    if (diff.isNegative) return 'Ended';
    if (diff.inDays >= 1) return '${diff.inDays}d left';
    if (diff.inHours >= 1) return '${diff.inHours}h left';
    return '${diff.inMinutes}m left';
  }
}
