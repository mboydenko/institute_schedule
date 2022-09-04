import 'package:hive/hive.dart';


@HiveType(typeId: 4, adapterName: 'TeacherAdapter')
class DbTeacher {

  DbTeacher({required this.firstName, required this.lastName, required this.middleName});

  @HiveField(0)
  String firstName;

  @HiveField(1)
  String lastName;

  @HiveField(2)
  String middleName;
}