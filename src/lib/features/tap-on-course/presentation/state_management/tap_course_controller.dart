import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/course_evaluation.dart';
import '../../domain/entities/group_category.dart';
import '../../domain/usecases/get_course_evaluations.dart';
import '../../domain/usecases/get_course_groups.dart';
import '../../domain/usecases/import_groups_from_csv.dart';
import 'package:src/features/home-professor/domain/entities/course.dart';

class TapCourseController extends GetxController {
  final GetCourseEvaluations getCourseEvaluations;
  final GetCourseGroups getCourseGroups;
  final ImportGroupsFromCsv importGroupsFromCsv;

  TapCourseController({
    required this.getCourseEvaluations,
    required this.getCourseGroups,
    required this.importGroupsFromCsv,
  });

  late final Course course;

  final RxInt selectedTab = 0.obs;
  final RxBool isLoading = true.obs;
  final RxBool isImporting = false.obs;

  final RxList<CourseEvaluation> evaluations = <CourseEvaluation>[].obs;
  final RxList<GroupCategory> groupCategories = <GroupCategory>[].obs;

  // Enrollment code derived from course data (mocked)
  String get enrollmentCode => 'DS-${course.period.split('-')[0]}-xka';

  int get groupCategoriesCount => groupCategories.length;

  @override
  void onInit() {
    super.onInit();
    course = Get.arguments as Course;
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading.value = true;
    final evals = await getCourseEvaluations(course.id);
    final groups = await getCourseGroups(course.id);
    evaluations.assignAll(evals);
    groupCategories.assignAll(groups);
    isLoading.value = false;
  }

  void selectTab(int index) => selectedTab.value = index;

  /// Called when the professor taps "+Add groups".
  /// Opens the system file picker so the user can select a CSV export.
  Future<void> onAddGroupsTapped() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );

    if (result == null || result.files.single.bytes == null) return;

    isImporting.value = true;

    final csvContent = String.fromCharCodes(result.files.single.bytes!);

  final imported = await importGroupsFromCsv(csvContent, course.id); 

    // Avoid duplicating a category that was already imported
    for (final newCat in imported) {
      final alreadyExists = groupCategories.any((c) => c.name == newCat.name);
      if (!alreadyExists) {
        groupCategories.add(newCat);
      }
    }

    isImporting.value = false;

    Get.snackbar(
      'Groups imported',
      '${imported.length} group ${imported.length == 1 ? 'category' : 'categories'} added from Brightspace.',
      backgroundColor: const Color(0xFF3A2016),
      colorText: const Color(0xFFFF8C60),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void onCreateEvaluationTapped() {
    Get.snackbar(
      'Coming soon',
      'Create evaluation will be available in the next release.',
      backgroundColor: const Color(0xFF3A2016),
      colorText: const Color(0xFFFF8C60),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}
