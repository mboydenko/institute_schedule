import 'dart:async';

import 'package:institute_schedules/domain/schedules/entities/coursework.dart';
import 'package:institute_schedules/domain/schedules/interfaces/coursework_repository.dart';

class MockCourseworkRepository implements CourseworkRepository {
  @override
  Future<List<Coursework>> getCourseWorksByGroupId(int groupId) async {
    return [];
  }

  @override
  Future<List<Coursework>> getCourseWorksByTeacherId(int teacherId) async {
    return [];
  }
}
