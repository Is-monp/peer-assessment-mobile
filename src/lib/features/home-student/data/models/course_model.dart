import '../../domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.code,
    required super.name,
    required super.period,
    required super.activeEvaluations,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      period: json['period'] as String,
      activeEvaluations: json['activeEvaluations'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'name': name,
    'period': period,
    'activeEvaluations': activeEvaluations,
  };
}
