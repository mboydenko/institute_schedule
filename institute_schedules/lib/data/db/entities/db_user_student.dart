import 'package:hive/hive.dart';
import 'package:institute_schedules/domain/users/models/user.dart';
import 'db_group.dart';

@HiveType(typeId: 2, adapterName: "UserStudentAdapter")
class DbUserStudent {

  DbUserStudent({required this.group, required this.subgroupNumber, required this.userType});

  @HiveField(0)
  DbGroup group;

  @HiveField(1)
  int subgroupNumber;

  @HiveField(2)
  UserType userType;
}