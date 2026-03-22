import '../models/course_evaluation_model.dart';
import '../models/group_category_model.dart';

abstract class TapCourseDatasource {
  Future<List<CourseEvaluationModel>> getCourseEvaluations(String courseId);
  Future<List<GroupCategoryModel>> getCourseGroups(String courseId);
}

class TapCourseDatasourceMock implements TapCourseDatasource {
  @override
  Future<List<CourseEvaluationModel>> getCourseEvaluations(String courseId) async {
    return [
      const CourseEvaluationModel(
        id: 'eval-1',
        name: 'Sprint 1 Peer review',
        status: CourseEvaluationStatus.closed,
        visibility: CourseEvaluationVisibility.public,
        durationMinutes: 60,
        respondedCount: 20,
      ),
      const CourseEvaluationModel(
        id: 'eval-2',
        name: 'Sprint 2 Peer review',
        status: CourseEvaluationStatus.active,
        visibility: CourseEvaluationVisibility.public,
        durationMinutes: 60,
        respondedCount: 1,
      ),
    ];
  }

  @override
  Future<List<GroupCategoryModel>> getCourseGroups(String courseId) async {
    return [
      GroupCategoryModel(
        name: 'Project Groups',
        source: 'Brightspace',
        groups: [
          CourseGroupModel(
            name: 'Group A',
            code: 'grp_001',
            members: [
              const GroupMemberModel(
                firstName: 'Isabella',
                lastName: 'Montes Palencia',
                email: 'isabellapalencia@uninorte.edu.co',
              ),
              const GroupMemberModel(
                firstName: 'John',
                lastName: 'Doe',
                email: 'Johndoe@uninorte.edu.co',
              ),
              const GroupMemberModel(
                firstName: 'Jane',
                lastName: 'Doe',
                email: 'Janedoe@uninorte.edu.co',
              ),
            ],
          ),
        ],
      ),
      GroupCategoryModel(
        name: 'Lab Partners',
        source: 'Brightspace',
        groups: [
          CourseGroupModel(
            name: 'Pair #6',
            code: 'grp_006',
            members: [
              const GroupMemberModel(
                firstName: 'Isabella',
                lastName: 'Montes Palencia',
                email: 'isabellapalencia@uninorte.edu.co',
              ),
              const GroupMemberModel(
                firstName: 'John',
                lastName: 'Doe',
                email: 'Johndoe@uninorte.edu.co',
              ),
            ],
          ),
        ],
      ),
    ];
  }

}
