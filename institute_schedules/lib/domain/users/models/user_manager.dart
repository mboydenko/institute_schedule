import 'package:flutter/cupertino.dart';
import '../exceptions/user_not_defined_exception.dart';
import '../../schedules/entities/student.dart';
import '../../schedules/entities/teacher.dart';
import 'user_student.dart';
import 'user_teacher.dart';
import 'user.dart';

class UserManager extends ChangeNotifier {
  User? _user;

  User get currentUser => _user == null ? throw UserNotDefinedException() : _user!;

  Future<void> loadLastState() async {

  }

  void switchToTeacher(Teacher teacher) {
    _user = UserTeacher(teacher);
  }

  void switchToStudent(Student student) {
    _user = UserStudent(student);
  }

  bool get isUserDefined {
    if(_user == null) return false;
    return true;
  }

  bool get isUserTeacher {
    if(isUserDefined) {
      return _user!.type == UserType.teacher;
    }
    return false;
  }

  bool get isUserStudent {
    if(isUserDefined) {
      return _user!.type == UserType.student;
    }
    return false;
  }
}