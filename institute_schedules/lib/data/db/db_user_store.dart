import 'package:hive/hive.dart';
import 'package:institute_schedules/data/db/entities/db_group.dart';
import 'package:institute_schedules/domain/users/interfaces/user_store.dart';
import 'package:institute_schedules/domain/users/models/user.dart';
import 'package:institute_schedules/domain/users/models/user_student.dart';
import 'package:institute_schedules/domain/users/models/user_teacher.dart';
import 'entities/db_user_student.dart';
import 'entities/db_user_teacher.dart';

class DbUserStore extends UserStore {
  @override
  Future<User> getLastUser() {
    // TODO: implement getLastUser
    throw UnimplementedError();
  }

  @override
  void saveUserStudent(UserStudent student) async {
    var group = DbGroup(
        name: student.student.group.name,
        numberOfSubgroups: student.student.group.numberOfSubgroups
    );
    var userStudent = DbUserStudent(
        group: group,
        subgroupNumber: student.student.subgroupNumber,
        userType: UserType.student
    );

    var box = await Hive.openBox('users');

    box.put('user', userStudent);
  }

  @override
  void saveUserTeacher(UserTeacher userTeacher) {

  }

}