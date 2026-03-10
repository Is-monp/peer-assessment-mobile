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

  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      id: json['id'] as String,
      courseCode: json['courseCode'] as String,
      title: json['title'] as String,
      courseName: json['courseName'] as String,
      status: EvaluationStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => EvaluationStatus.pending,
      ),
      timeRemaining: json['timeRemaining'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'courseCode': courseCode,
    'title': title,
    'courseName': courseName,
    'status': status.name,
    'timeRemaining': timeRemaining,
  };
}
