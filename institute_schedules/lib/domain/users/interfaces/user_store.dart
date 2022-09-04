import '../models/user.dart';
import '../models/user_teacher.dart';
import '../models/user_student.dart';

abstract class UserStore {
  void saveUserStudent(UserStudent student);

  void saveUserTeacher(UserTeacher userTeacher);

  Future<User> getLastUser();
}