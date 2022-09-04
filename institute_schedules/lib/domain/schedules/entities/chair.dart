import 'teacher.dart';

class Chair {
  final int id;
  final String name;
  final String abbreviation;
  final List<Teacher> teachers;

  Chair(
      {required this.name,
      required this.abbreviation,
      required this.teachers,
      required this.id});
}
