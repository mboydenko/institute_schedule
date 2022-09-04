import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:institute_schedules/domain/schedules/entities/lesson.dart';
import 'package:institute_schedules/domain/schedules/entities/week.dart';
import 'package:institute_schedules/domain/schedules/interfaces/lesson_repository.dart';
import 'package:institute_schedules/domain/schedules/entities/building.dart';
import 'package:institute_schedules/domain/schedules/entities/class_room.dart';
import 'package:institute_schedules/domain/schedules/entities/group.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/constants/lesson_type_numbers.dart';
import 'package:institute_schedules/domain/schedules/entities/date.dart';
import 'package:institute_schedules/domain/schedules/entities/day.dart';
import 'package:institute_schedules/domain/schedules/entities/discipline.dart';


class ApiLessonRepository extends LessonRepository {
  final apiUrl =  "${dotenv.env['API_URL']}/lessons";

  @override
  Future<List<Lesson>> getLessonsByGroupId(int groupId) async {
    var uri = Uri.parse("$apiUrl?group_id=$groupId");

    var httpResponse = await http.get(uri);

    var array = convert.jsonDecode(convert.utf8.decode(httpResponse.bodyBytes))
        as List<dynamic>;

    if(kDebugMode) {
      print("Received Data:");
      print(array);
    }

    var lessons = <Lesson>[];

    for (var element in array) {

      var disciplineMap = element['discipline'] as Map<String, dynamic>;

      var teacherMap = element['teacher'] as Map<String, dynamic>;

      var lessonNumber = element['number'] as int;

      var lessonTypeNumber = element['lesson_type'] as int;

      var weekTypeNumber = element['week_type'] as int;

      var weekDay = element['week_day'] as int;

      var begin = element['begin'];

      var end = element['end'];

      var subgroupNumber = element['subgroup_number'];

      var buildingMap = element['building'] as Map<String, dynamic>;

      var classroomMap = element['classroom'] as Map<String, dynamic>;

      var groupsMap = element['all_groups'] as List<dynamic>;

      var discipline = Discipline(
          name: disciplineMap['name'], id: disciplineMap['id'] as int);

      var teacher = Teacher(
          id: teacherMap['id'],
          firstName: teacherMap['first_name'],
          middleName: teacherMap['middle_name'],
          lastName: teacherMap['last_name'],
          email: teacherMap['email']);

      var classroom =
          ClassRoom(id: classroomMap['id'] as int, name: classroomMap['name']);

      var building = Building(
          id: buildingMap['id'],
          name: buildingMap['name'],
          shortName: buildingMap['short_name']);

      var weekType = weekTypeNumber == 1 ? WeekType.odd : WeekType.even;

      var dayType = weekDay == 1
          ? DayType.monday
          : weekDay == 2
              ? DayType.tuesday
              : weekDay == 3
                  ? DayType.wednesday
                  : weekDay == 4
                      ? DayType.thursday
                      : weekDay == 5
                          ? DayType.friday
                          : DayType.saturday;

      var lessonType = lessonTypeNumber == LESSON_TYPE_LAB_WORK_NUMBER
          ? LessonType.laboratoryWork
          : lessonTypeNumber == LESSON_TYPE_LECTURE_NUMBER
              ? LessonType.lecture
              : LessonType.practice;

      var dateOfBegin = DateTime.parse(begin);

      var dateOfEnd = DateTime.parse(end);

      var lessonGroups = <LessonGroup>[];

      for (var lessonGroupMap in groupsMap) {
        var groupMap = lessonGroupMap['group'] as Map<String, dynamic>;

        var group = Group(
            name: groupMap['name'],
            id: groupMap['id'],
            numberOfSubgroups: groupMap['number_of_subgroups']);

        var lessonGroup =
            LessonGroup(group: group, subgroupNumber: subgroupNumber);

        lessonGroups.add(lessonGroup);
      }

      var lesson = Lesson(
          number: lessonNumber,
          discipline: discipline,
          groups: lessonGroups,
          teacher: teacher,
          lessonType: lessonType,
          building: building,
          classRoom: classroom,
          dateOfBegin: Date(
            year: dateOfBegin.year,
            month: dateOfBegin.month,
            day: dateOfBegin.day
          ),
          dateOfEnd: Date(
              year: dateOfEnd.year,
              month: dateOfEnd.month,
              day: dateOfEnd.day
          ),
          dayType: dayType,
          weekType: weekType,
          subgroupNumber: subgroupNumber);

      lessons.add(lesson);
    }

    if(kDebugMode) {
      print("Received lessons:");
      print(lessons);
    }

    return lessons;
  }

  @override
  Future<List<Lesson>> getLessonsByTeacherId(int teacherId) async {
    var uri = Uri.parse("$apiUrl?teacher_id=$teacherId");

    var httpResponse = await http.get(uri);

    var array = convert.jsonDecode(convert.utf8.decode(httpResponse.bodyBytes))
    as List<dynamic>;

    if(kDebugMode) {
      print("Received Data:");
      print(array);
    }

    var lessons = <Lesson>[];

    for (var element in array) {

      var disciplineMap = element['discipline'] as Map<String, dynamic>;

      var teacherMap = element['teacher'] as Map<String, dynamic>;

      var lessonNumber = element['number'] as int;

      var lessonTypeNumber = element['lesson_type'] as int;

      var weekTypeNumber = element['week_type'] as int;

      var weekDay = element['week_day'] as int;

      var begin = element['begin'];

      var end = element['end'];

      var subgroupNumber = element['subgroup_number'];

      var buildingMap = element['building'] as Map<String, dynamic>;

      var classroomMap = element['classroom'] as Map<String, dynamic>;

      var groupsMap = element['all_groups'] as List<dynamic>;

      var discipline = Discipline(
          name: disciplineMap['name'], id: disciplineMap['id'] as int);

      var teacher = Teacher(
          id: teacherMap['id'],
          firstName: teacherMap['first_name'],
          middleName: teacherMap['middle_name'],
          lastName: teacherMap['last_name'],
          email: teacherMap['email']);

      var classroom =
      ClassRoom(id: classroomMap['id'] as int, name: classroomMap['name']);

      var building = Building(
          id: buildingMap['id'],
          name: buildingMap['name'],
          shortName: buildingMap['short_name']);

      var weekType = weekTypeNumber == 1 ? WeekType.odd : WeekType.even;

      var dayType = weekDay == 1
          ? DayType.monday
          : weekDay == 2
          ? DayType.tuesday
          : weekDay == 3
          ? DayType.wednesday
          : weekDay == 4
          ? DayType.thursday
          : weekDay == 5
          ? DayType.friday
          : DayType.saturday;

      var lessonType = lessonTypeNumber == LESSON_TYPE_LAB_WORK_NUMBER
          ? LessonType.laboratoryWork
          : lessonTypeNumber == LESSON_TYPE_LECTURE_NUMBER
          ? LessonType.lecture
          : LessonType.practice;

      var dateOfBegin = DateTime.parse(begin);

      var dateOfEnd = DateTime.parse(end);

      var lessonGroups = <LessonGroup>[];

      for (var lessonGroupMap in groupsMap) {
        var groupMap = lessonGroupMap['group'] as Map<String, dynamic>;

        var group = Group(
            name: groupMap['name'],
            id: groupMap['id'],
            numberOfSubgroups: groupMap['number_of_subgroups']);

        var lessonGroup =
        LessonGroup(group: group, subgroupNumber: subgroupNumber);

        lessonGroups.add(lessonGroup);
      }

      var lesson = Lesson(
          number: lessonNumber,
          discipline: discipline,
          groups: lessonGroups,
          teacher: teacher,
          lessonType: lessonType,
          building: building,
          classRoom: classroom,
          dateOfBegin: Date(
              year: dateOfBegin.year,
              month: dateOfBegin.month,
              day: dateOfBegin.day
          ),
          dateOfEnd: Date(
              year: dateOfEnd.year,
              month: dateOfEnd.month,
              day: dateOfEnd.day
          ),
          dayType: dayType,
          weekType: weekType,
          subgroupNumber: subgroupNumber);

      lessons.add(lesson);
    }

    if(kDebugMode) {
      print("Received lessons:");
      print(lessons);
    }

    return lessons;
  }
}
