import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';
import 'package:src/core/i_local_preferences.dart';
import 'package:src/features/home-student/data/datasources/home_student_datasource.dart';
import 'package:src/features/home-student/data/models/course_model.dart';
import 'package:src/features/home-student/data/models/evaluation_model.dart';

class RemoteHomeStudentDataSource implements HomeStudentDataSource {
  final http.Client httpClient;

  final String contract = dotenv.get(
    'EXPO_PUBLIC_ROBLE_PROJECT_ID',
    fallback: "NO_ENV",
  );
  final String baseUrl = 'roble-api.openlab.uninorte.edu.co';

  RemoteHomeStudentDataSource(this.httpClient);

  /// Resolves enrolled courses for a student via a 4-step chain:
  /// 1. grupitos (correo=email)    a  unique GroupCategory names
  /// 2. group_categories (name=...) a course_id values
  /// 3. cursos (_id=course_id)     a  Course entities
  @override
  Future<List<CourseModel>> getEnrolledCourses(String studentEmail) async {
    final ILocalPreferences prefs = Get.find();
    final token = await prefs.getString('token');
    final headers = {'Authorization': 'Bearer $token'};

    // find all grupitos rows where correo matches the student
    final grupitosUri = Uri.https(baseUrl, '/database/$contract/read', {
      'tableName': 'grupitos',
      'correo': studentEmail,
    });

    final grupitosResponse = await httpClient.get(grupitosUri, headers: headers);

    if (grupitosResponse.statusCode != 200) {
      logError('getEnrolledCourses grupitos error ${grupitosResponse.statusCode}');
      return Future.error('Error ${grupitosResponse.statusCode}');
    }

    final List<dynamic> grupitos = jsonDecode(grupitosResponse.body);

    // collect unique GroupCategory names
    final Set<String> categoryNames = grupitos
        .map((g) => g['GroupCategory'] as String)
        .toSet();

    if (categoryNames.isEmpty) return [];

    // for each GroupCategory name, query group_categories to get course_id
    final Set<String> courseIds = {};

    for (final name in categoryNames) {
      final catUri = Uri.https(baseUrl, '/database/$contract/read', {
        'tableName': 'group_categories',
        'name': name,
      });

      final catResponse = await httpClient.get(catUri, headers: headers);

      if (catResponse.statusCode != 200) {
        logError('getEnrolledCourses group_categories error ${catResponse.statusCode}');
        continue;
      }

      final List<dynamic> categories = jsonDecode(catResponse.body);
      for (final cat in categories) {
        final courseId = cat['course_id'] as String?;
        if (courseId != null) courseIds.add(courseId);
      }
    }

    if (courseIds.isEmpty) return [];

    //fetch each course from cursos by _id
    final List<CourseModel> courses = [];

    for (final courseId in courseIds) {
      final courseUri = Uri.https(baseUrl, '/database/$contract/read', {
        'tableName': 'cursos',
        '_id': courseId,
      });

      final courseResponse = await httpClient.get(courseUri, headers: headers);

      if (courseResponse.statusCode != 200) {
        logError('getEnrolledCourses cursos error ${courseResponse.statusCode}');
        continue;
      }

      final List<dynamic> rows = jsonDecode(courseResponse.body);
      for (final row in rows) {
        courses.add(CourseModel.fromJson(row));
      }
    }

    return courses;
  }

  @override
  Future<List<EvaluationModel>> getActiveEvaluations(String studentId) async {
    // TODO: implement when evaluations endpoint is ready
    return [];
  }
}
