import '../entities/coursework.dart';

abstract class CourseworkRepository {
  Future<List<Coursework>> getCourseWorksByTeacherId(int teacherId);

  Future<List<Coursework>> getCourseWorksByGroupId(int groupId);
}