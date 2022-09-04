import 'package:flutter/cupertino.dart';
import 'package:institute_schedules/domain/schedules/models/schedules.dart';

enum UserType {
  teacher,
  student
}


abstract class User extends ChangeNotifier {
  final UserType type;

  final Schedules schedules;

  User({required this.type, required this.schedules});

  bool get isStudent => type == UserType.student;

  bool get isTeacher => type == UserType.teacher;

  String get name;
}