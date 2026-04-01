import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:src/features/auth/presentation/viewmodels/user_controller.dart';
import 'package:src/features/home-professor/domain/entities/course.dart'
    as prof_course;
import 'package:src/core/i_local_preferences.dart';
import 'package:src/features/home-professor/domain/repositories/home_professor_repository.dart';
import 'package:src/features/home-professor/domain/usecases/get_assigned_courses.dart';
import 'package:src/features/home-professor/presentation/pages/home_professor_page.dart';
import 'package:src/features/home-professor/presentation/state_management/home_professor_controller.dart';
import 'package:src/features/home-professor/presentation/widgets/course_card.dart'
    as professor_course_card;
import 'package:src/features/home-student/domain/entities/course.dart'
    as stud_course;
import 'package:src/features/home-student/domain/entities/evaluation.dart'
    as stud_eval;
import 'package:src/features/home-student/domain/repositories/home_student_repository.dart';
import 'package:src/features/home-student/domain/usecases/get_active_evaluations.dart';
import 'package:src/features/home-student/domain/usecases/get_enrolled_courses.dart';
import 'package:src/features/home-student/presentation/pages/home_student_page.dart';
import 'package:src/features/home-student/presentation/state_management/home_student_controller.dart';
import 'package:src/features/home-student/presentation/widgets/course_card.dart'
    as student_course_card;
import 'package:src/features/home-student/presentation/widgets/evaluation_card.dart';
import 'package:src/features/tap-on-course/domain/entities/course_evaluation.dart';
import 'package:src/features/tap-on-course/domain/entities/course_group.dart';
import 'package:src/features/tap-on-course/domain/entities/group_category.dart';
import 'package:src/features/tap-on-course/domain/entities/group_member.dart';
import 'package:src/features/tap-on-course/presentation/models/course_ui.dart';
import 'package:src/features/tap-on-course/domain/repositories/tap_course_repository.dart';
import 'package:src/features/tap-on-course/domain/usecases/get_course_evaluations.dart';
import 'package:src/features/tap-on-course/domain/usecases/get_course_groups.dart';
import 'package:src/features/tap-on-course/domain/usecases/import_groups_from_csv.dart';
import 'package:src/features/tap-on-course/presentation/pages/tap_course_page.dart';
import 'package:src/features/tap-on-course/presentation/state_management/tap_course_controller.dart';
import 'package:src/features/tap-on-course/presentation/widgets/course_evaluation_card.dart';
import 'package:src/features/tap-on-course/presentation/widgets/group_category_section.dart';

import 'feature_widget_mocks.dart';
import 'mockUserController.dart';

void main() {
  setUp(() {
    Get.reset();
    Get.testMode = true;
    Get.put<ILocalPreferences>(FakeLocalPreferences());
    Get.put<UserController>(FakeUserController());
  });

  Widget buildTestApp(Widget child) {
    return GetMaterialApp(home: child);
  }

  testWidgets('HomeProfessorPage renders header, stats and course list', (
    tester,
  ) async {
    Get.put<HomeProfessorController>(FakeHomeProfessorController());

    await tester.pumpWidget(buildTestApp(const HomeProfessorPage()));
    await tester.pumpAndSettle();

    expect(find.text('Hello,'), findsOneWidget);
    expect(find.text('Jane Smith'), findsOneWidget);
    expect(find.text('Teacher · Computer Science'), findsOneWidget);
    expect(find.text('Courses'), findsOneWidget);
    expect(find.text('1'), findsWidgets);
    expect(find.text('30'), findsOneWidget);
    expect(find.text('2'), findsWidgets);
    expect(find.text('My Courses'), findsOneWidget);
    expect(find.text('Introduction to Testing'), findsOneWidget);
    expect(find.text('2024-Fall'), findsOneWidget);
    expect(find.text('30 students'), findsOneWidget);
    expect(find.text('2 evaluations'), findsOneWidget);
  });

  testWidgets(
    'HomeStudentPage renders student header, active evaluations and enrolled courses',
    (tester) async {
      Get.put<HomeStudentController>(FakeHomeStudentController());

      await tester.pumpWidget(buildTestApp(const HomeStudentPage()));
      await tester.pumpAndSettle();

      expect(find.text('Hello,'), findsOneWidget);
      expect(find.text('Alice Cooper'), findsOneWidget);
      expect(find.text('Student'), findsOneWidget);
      expect(find.text('Active Evaluations'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('My Courses'), findsOneWidget);
      expect(find.text('Advanced Flutter'), findsOneWidget);
      expect(find.text('2024-Spring'), findsOneWidget);
    },
  );

  testWidgets(
    'TapCoursePage renders course info, enrollment code and toggles tabs',
    (tester) async {
      Get.put<TapCourseController>(FakeTapCourseController());

      await tester.pumpWidget(buildTestApp(const TapCoursePage()));
      await tester.pumpAndSettle();

      expect(
        find.text('Principles and practices of modern software development.'),
        findsOneWidget,
      );
      expect(find.text('CS101 · 2024-Fall'), findsOneWidget);
      expect(find.text('DS-2024-xka'), findsOneWidget);
      expect(find.text('Evaluations'), findsOneWidget);
      expect(find.text('+ Create evaluation'), findsOneWidget);
      expect(find.text('Midterm evaluation'), findsOneWidget);

      await tester.tap(find.text('Groups'));
      await tester.pumpAndSettle();

      expect(find.text('+Add groups'), findsOneWidget);
      expect(find.text('Group A'), findsOneWidget);
      expect(find.text('Brightspace'), findsOneWidget);
    },
  );

  testWidgets('Professor CourseCard displays all course details', (
    tester,
  ) async {
    var tapped = false;
    final course = prof_course.Course(
      id: 'course-1',
      code: 'CS101',
      name: 'Introduction to Testing',
      period: '2024-Fall',
      studentsCount: 30,
      activeEvaluations: 2,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: professor_course_card.CourseCard(
          course: course,
          onTap: () => tapped = true,
        ),
      ),
    );

    expect(find.text('CS101'), findsOneWidget);
    expect(find.text('Introduction to Testing'), findsOneWidget);
    expect(find.text('2024-Fall'), findsOneWidget);
    expect(find.text('30 students'), findsOneWidget);
    expect(find.text('2 evaluations'), findsOneWidget);

    await tester.tap(find.text('Introduction to Testing'));
    expect(tapped, isTrue);
  });

  testWidgets('Student CourseCard displays course title and period', (
    tester,
  ) async {
    var tapped = false;
    final course = stud_course.Course(
      id: 'course-2',
      code: 'ST201',
      name: 'Advanced Flutter',
      period: '2024-Spring',
      activeEvaluations: 1,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: student_course_card.CourseCard(
          course: course,
          onTap: () => tapped = true,
        ),
      ),
    );

    expect(find.text('ST201'), findsOneWidget);
    expect(find.text('Advanced Flutter'), findsOneWidget);
    expect(find.text('2024-Spring'), findsOneWidget);

    await tester.tap(find.text('Advanced Flutter'));
    expect(tapped, isTrue);
  });

  testWidgets('EvaluationCard shows open evaluation and triggers onTap', (
    tester,
  ) async {
    var tapped = false;
    final evaluation = stud_eval.Evaluation(
      id: 'eval-1',
      courseCode: 'CS101',
      title: 'Final exam',
      courseName: 'Introduction to Testing',
      status: stud_eval.EvaluationStatus.open,
      timeRemaining: '2d 5h',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: EvaluationCard(
          evaluation: evaluation,
          onTap: () => tapped = true,
        ),
      ),
    );

    expect(find.text('Final exam'), findsOneWidget);
    expect(find.text('Introduction to Testing'), findsOneWidget);
    expect(find.text('Evaluate now →'), findsOneWidget);

    await tester.tap(find.text('Evaluate now →'));
    expect(tapped, isTrue);
  });

  testWidgets(
    'CourseEvaluationCard displays action label for closed and active evaluation',
    (tester) async {
      var tapped = false;
      final evaluation = CourseEvaluation(
        id: 'ce-1',
        name: 'Midterm evaluation',
        status: 'active',
        visibility: 'public',
        groupCategory: 'Group A',
        deadline: DateTime(2025, 5, 10, 14, 30),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CourseEvaluationCard(
            evaluation: evaluation,
            onEvaluate: () => tapped = true,
            onViewResults: null,
          ),
        ),
      );

      expect(find.text('Midterm evaluation'), findsOneWidget);
      expect(find.text('Public'), findsOneWidget);
      expect(find.text('Evaluate now →'), findsOneWidget);

      await tester.tap(find.text('Evaluate now →'));
      expect(tapped, isTrue);
    },
  );

  testWidgets('GroupCategorySection renders category details and member list', (
    tester,
  ) async {
    final category = GroupCategory(
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
    );

    await tester.pumpWidget(
      MaterialApp(home: GroupCategorySection(category: category)),
    );

    expect(find.text('Group A'), findsOneWidget);
    expect(find.text('Brightspace'), findsOneWidget);
    expect(find.text('Project Team'), findsOneWidget);
    expect(find.text('1 member'), findsOneWidget);
    expect(find.text('Ada Lovelace'), findsOneWidget);
    expect(find.text('ada@uni.edu'), findsOneWidget);
  });
}
