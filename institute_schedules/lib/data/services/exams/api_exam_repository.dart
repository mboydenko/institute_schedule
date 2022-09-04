import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:institute_schedules/domain/schedules/entities/building.dart';
import 'package:institute_schedules/domain/schedules/entities/class_room.dart';
import 'package:institute_schedules/domain/schedules/entities/group.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/entities/date.dart';
import 'package:institute_schedules/domain/schedules/entities/discipline.dart';
import 'package:institute_schedules/domain/schedules/entities/exam.dart';
import 'package:institute_schedules/domain/schedules/entities/time.dart';
import 'package:institute_schedules/domain/schedules/interfaces/exam_repository.dart';

class ApiExamRepository extends ExamRepository {
  final apiUrl =  "${dotenv.env['API_URL']}/exams";

  @override
  Future<List<Exam>> getExamsByGroupId(int id) async {

    var url = Uri.parse("$apiUrl?group_id=$id");

    var response = await http.get(url);

    var jsonResponse =
    convert.jsonDecode(
        convert.utf8.decode(response.bodyBytes)
    ) as List<dynamic>;

    return parseFromJsonArray(jsonResponse);
  }

  @override
  Future<List<Exam>> getExamsByTeacherId(int id) async {
    var url = Uri.parse("$apiUrl?teacher_id=$id");

    var response = await http.get(url);

    var jsonResponse =
    convert.jsonDecode(
        convert.utf8.decode(response.bodyBytes)
    ) as List<dynamic>;

    return parseFromJsonArray(jsonResponse);
  }

  List<Exam> parseFromJsonArray(List<dynamic> data) {
    var exams = <Exam>[];

    for(var element in data) {

      var discipline = Discipline(
          name: element['discipline']['name'],
          id: element['discipline']['id']
      );

      var teacher = Teacher(
          id: element['teacher']['id'],
          firstName: element['teacher']['first_name'],
          lastName: element['teacher']['last_name'],
          middleName: element['teacher']['middle_name']
      );

      var group = Group(
          name: element['group']['name'],
          id: element['group']['id'],
          numberOfSubgroups: element['group']['number_of_subgroups']
      );

      var building = Building(
          id: element['building']['id'],
          name: element['building']['name'],
          shortName: element['building']['short_name']
      );

      var classroom = ClassRoom(
          id: element['classroom']['id'],
          name: element['classroom']['name']
      );

      var datetime = DateTime.parse("${element['date']} ${element['time']}");

      var date = Date(
          day: datetime.day,
          month: datetime.month,
          year: datetime.year
      );

      var time = Time(
          hours: datetime.hour,
          minutes: datetime.minute
      );

      var examType = element['exam_type'] == 1 ? ExamType.exam : ExamType.consultation;

      var exam = Exam(
          discipline: discipline,
          groups: [group],
          teacher: teacher,
          time: time,
          date: date,
          classRoom: classroom,
          building: building,
          type: examType
      );

      exams.add(exam);
    }

    return exams;
  }

}