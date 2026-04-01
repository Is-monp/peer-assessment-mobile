import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:src/core/i_local_preferences.dart';
import 'package:src/features/home-professor/domain/entities/course.dart'
    as prof_course;
import 'package:src/features/home-professor/domain/repositories/home_professor_repository.dart';
import 'package:src/features/home-professor/domain/usecases/get_assigned_courses.dart';
import 'package:src/features/home-professor/presentation/state_management/home_professor_controller.dart';
import 'package:src/features/home-student/domain/entities/course.dart'
    as stud_course;
import 'package:src/features/home-student/domain/entities/evaluation.dart'
    as stud_eval;
import 'package:src/features/home-student/domain/repositories/home_student_repository.dart';
import 'package:src/features/home-student/domain/usecases/get_active_evaluations.dart';
import 'package:src/features/home-student/domain/usecases/get_enrolled_courses.dart';
import 'package:src/features/home-student/presentation/state_management/home_student_controller.dart';
import 'package:src/features/tap-on-course/domain/entities/course_evaluation.dart';
import 'package:src/features/tap-on-course/domain/entities/course_group.dart';
import 'package:src/features/tap-on-course/domain/entities/group_category.dart';
import 'package:src/features/tap-on-course/domain/entities/group_member.dart';
import 'package:src/features/tap-on-course/domain/repositories/tap_course_repository.dart';
import 'package:src/features/tap-on-course/domain/usecases/get_course_evaluations.dart';
import 'package:src/features/tap-on-course/domain/usecases/get_course_groups.dart';
import 'package:src/features/tap-on-course/domain/usecases/import_groups_from_csv.dart';
import 'package:src/features/tap-on-course/presentation/models/course_ui.dart';
import 'package:src/features/tap-on-course/presentation/state_management/tap_course_controller.dart';

class FakeLocalPreferences implements ILocalPreferences {
  final Map<String, Object> _storage = {};

  @override
  Future<void> clear() async {
    _storage.clear();
  }

  @override
  Future<bool?> getBool(String key) async => _storage[key] as bool?;

  @override
  Future<double?> getDouble(String key) async => _storage[key] as double?;

  @override
  Future<int?> getInt(String key) async => _storage[key] as int?;

  @override
  Future<List<String>?> getStringList(String key) async =>
      _storage[key] as List<String>?;

  @override
  Future<String?> getString(String key) async => _storage[key] as String?;

  @override
  Future<void> remove(String key) async {
    _storage.remove(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    _storage[key] = value;
  }

  @override
  Future<void> setDouble(String key, double value) async {
    _storage[key] = value;
  }

  @override
  Future<void> setInt(String key, int value) async {
    _storage[key] = value;
  }

  @override
  Future<void> setString(String key, String value) async {
    _storage[key] = value;
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    _storage[key] = value;
  }
}

class FakeHomeProfessorRepository extends HomeProfessorRepository {
  @override
  Future<List<prof_course.Course>> getAssignedCourses(
    String professorId,
  ) async {
    return [];
  }
}

class FakeHomeProfessorController extends HomeProfessorController {
  FakeHomeProfessorController()
    : super(
        getAssignedCourses: GetAssignedCourses(FakeHomeProfessorRepository()),
      ) {
    professorName.value = 'Jane Smith';
    courses.assignAll([
      prof_course.Course(
        id: 'course-1',
        code: 'CS101',
        name: 'Introduction to Testing',
        period: '2024-Fall',
        studentsCount: 30,
        activeEvaluations: 2,
      ),
    ]);
    coursesCount.value = 1;
    studentsCount.value = 30;
    activeEvaluations.value = 2;
  }

  @override
  void onInit() {}
}

class FakeHomeStudentRepository implements HomeStudentRepository {
  @override
  Future<List<stud_eval.Evaluation>> getActiveEvaluations(
    String studentId,
  ) async {
    return [];
  }

  @override
  Future<List<stud_course.Course>> getEnrolledCourses(String studentId) async {
    return [];
  }
}

class FakeHomeStudentController extends HomeStudentController {
  FakeHomeStudentController()
    : super(
        getActiveEvaluations: GetActiveEvaluations(FakeHomeStudentRepository()),
        getEnrolledCourses: GetEnrolledCourses(FakeHomeStudentRepository()),
      ) {
    studentName.value = 'Alice Cooper';
    evaluations.assignAll([
      stud_eval.Evaluation(
        id: 'eval-1',
        courseCode: 'CS101',
        title: 'Final exam',
        courseName: 'Introduction to Testing',
        status: stud_eval.EvaluationStatus.open,
        timeRemaining: '2d 5h',
      ),
    ]);
    courses.assignAll([
      stud_course.Course(
        id: 'course-2',
        code: 'ST201',
        name: 'Advanced Flutter',
        period: '2024-Spring',
        activeEvaluations: 1,
      ),
    ]);
    isLoading.value = false;
  }

  @override
  void onInit() {}
}

class FakeTapCourseRepository implements TapCourseRepository {
  @override
  Future<List<GroupCategory>> getCourseGroups(String courseId) async {
    return [
      GroupCategory(
        name: 'Group A',
        source: 'Brightspace',
        groups: [
          CourseGroup(
            name: 'Project Team',
            code: 'G1',
            members: const [
              GroupMember(
                firstName: 'Ada',
                lastName: 'Lovelace',
                email: 'ada@uni.edu',
              ),
            ],
          ),
        ],
      ),
    ];
  }

  @override
  Future<List<CourseEvaluation>> getCourseEvaluations(String courseId) async {
    return [
      CourseEvaluation(
        id: 'ce-1',
        name: 'Midterm evaluation',
        status: 'active',
        visibility: 'public',
        groupCategory: 'Group A',
        deadline: DateTime(2025, 5, 10, 14, 30),
      ),
    ];
  }

  @override
  Future<List<GroupCategory>> importGroupsFromCsv(
    String csvContent,
    String courseId,
  ) async {
    return [
      GroupCategory(
        name: 'Imported groups',
        source: 'Brightspace',
        groups: const [],
      ),
    ];
  }
}

class FakeTapCourseController extends TapCourseController {
  FakeTapCourseController()
    : super(
        getCourseEvaluations: GetCourseEvaluations(FakeTapCourseRepository()),
        getCourseGroups: GetCourseGroups(FakeTapCourseRepository()),
        importGroupsFromCsv: ImportGroupsFromCsv(FakeTapCourseRepository()),
      ) {
    course = CourseUI(
      id: 'course-3',
      code: 'CS101',
      name: 'Software Development',
      period: '2024-Fall',
      studentsCount: 40,
      activeEvaluations: 3,
    );
    isProfessor = true;
    selectedTab.value = 0;
    isLoading.value = false;
    isImporting.value = false;
    evaluations.assignAll([
      CourseEvaluation(
        id: 'ce-1',
        name: 'Midterm evaluation',
        status: 'active',
        visibility: 'public',
        groupCategory: 'Group A',
        deadline: DateTime(2025, 5, 10, 14, 30),
      ),
    ]);
    groupCategories.assignAll([
      GroupCategory(
        name: 'Group A',
        source: 'Brightspace',
        groups: [
          CourseGroup(
            name: 'Project Team',
            code: 'G1',
            members: const [
              GroupMember(
                firstName: 'Ada',
                lastName: 'Lovelace',
                email: 'ada@uni.edu',
              ),
            ],
          ),
        ],
      ),
    ]);
  }

  @override
  void onInit() {}
}
