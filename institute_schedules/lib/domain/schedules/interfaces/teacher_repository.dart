import '../entities/teacher.dart';

abstract class TeacherRepository {
  Future<Teacher> getTeacherById(int teacherId);

  Future<List<Teacher>> getTeachersByPathOfName(String pathOfName);
}
