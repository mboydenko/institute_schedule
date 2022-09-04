import 'package:institute_schedules/domain/schedules/entities/building.dart';
import 'package:institute_schedules/domain/schedules/entities/class_room.dart';
import 'package:institute_schedules/domain/schedules/entities/coursework.dart';
import 'package:institute_schedules/domain/schedules/entities/date.dart';
import 'package:institute_schedules/domain/schedules/entities/discipline.dart';
import 'package:institute_schedules/domain/schedules/entities/group.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/entities/time.dart';
import 'package:institute_schedules/domain/schedules/interfaces/coursework_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ApiCourseworkRepository extends CourseworkRepository {
  final apiUrl =  "${dotenv.env['API_URL']}/coursework";

  @override
  Future<List<Coursework>> getCourseWorksByGroupId(int groupId) async {
    var url = Uri.parse("$apiUrl?group_id=$groupId");

    var response = await http.get(url);

    var jsonResponse =
    convert.jsonDecode(
        convert.utf8.decode(response.bodyBytes)
    ) as List<dynamic>;

    return parseFromJsonArray(jsonResponse);
  }

  @override
  Future<List<Coursework>> getCourseWorksByTeacherId(int teacherId) async {
    var url = Uri.parse("$apiUrl?teacher_id=$teacherId");

    var response = await http.get(url);

    var jsonResponse =
    convert.jsonDecode(
        convert.utf8.decode(response.bodyBytes)
    ) as List<dynamic>;

    return parseFromJsonArray(jsonResponse);
  }

  Coursework parseFromJsonOne(Map<String, dynamic> data) {
    var discipline = Discipline(
        name: data['discipline']['name'],
        id: data['discipline']['id']
    );

    var group = Group(
      id: data['group']['id'],
      name: data['group']['name'],
      numberOfSubgroups: data['group']['number_of_subgroups']
    );

    var building = Building(
        id: data['building']['id'],
        name: data['building']['name'],
        shortName: data['building']['short_name']
    );

    var classroom = ClassRoom(
        id: data['classroom']['id'],
        name: data['classroom']['name']
    );

    var datetime = DateTime.parse("${data['date']} ${data['time']}");

    var date = Date(
        day: datetime.day,
        month: datetime.month,
        year: datetime.year
    );

    var time = Time(
        hours: datetime.hour,
        minutes: datetime.minute
    );

    var teachers = <Teacher>[];

    for(var teacherData in data['teachers']) {
      var teacher = Teacher(
          id: teacherData['id'],
          firstName: teacherData['first_name'],
          lastName: teacherData['last_name'],
          middleName: teacherData['middle_name']
      );
      teachers.add(teacher);
    }

    var coursework = Coursework(
        id: data['id'],
        commissionComposition: teachers,
        group: group,
        discipline: discipline,
        time: time,
        date: date,
        building: building,
        classRoom: classroom
    );

    return coursework;
  }

  List<Coursework> parseFromJsonArray(List<dynamic> data) {
    var courseworks = <Coursework>[];

    for(var courseworkData in data) {
      var coursework = parseFromJsonOne(courseworkData);
      courseworks.add(coursework);
    }

    return courseworks;
  }

}