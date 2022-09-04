import '../entities/lesson.dart';


abstract class LessonRepository {
  Future<List<Lesson>> getLessonsByTeacherId(int teacherId);

  Future<List<Lesson>> getLessonsByGroupId(int teacherId);
}
