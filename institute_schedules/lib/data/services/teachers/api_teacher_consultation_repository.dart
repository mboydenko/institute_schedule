import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:institute_schedules/domain/schedules/entities/building.dart';
import 'package:institute_schedules/domain/schedules/entities/class_room.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/entities/day.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher_consultation.dart';
import 'package:institute_schedules/domain/schedules/entities/time.dart';
import 'package:institute_schedules/domain/schedules/entities/week.dart';
import 'package:institute_schedules/domain/schedules/interfaces/teacher_consultation_repository.dart';

class ApiTeacherConsultationRepository extends TeacherConsultationRepository {
  final apiUrl =  "${dotenv.env['API_URL']}/teacher_consultations";

  @override
  Future<List<TeacherConsultation>> getTeacherConsultationsById(int teacherId) async {
    var url = Uri.parse("$apiUrl?teacher_id=$teacherId");

    var response = await http.get(url);

    var jsonResponse = convert.jsonDecode(
        convert.utf8.decode(response.bodyBytes)
    ) as List<dynamic>;

    return parseFromJsonArray(jsonResponse);
  }

  TeacherConsultation parseFromJsonOne(Map<String, dynamic> data) {
    // var teacher = Teacher(
    //     id: data['teacher']['id'],
    //     firstName: data['teacher']['first_name'],
    //     lastName: data['teacher']['last_name'],
    //     middleName: data['teacher']['middle_name']
    // );

    var building = Building(
      id: data['building']['id'],
      name: data['building']['name'],
      shortName: data['building']['short_name']
    );

    var classroom = ClassRoom(
        id: data['classroom']['id'],
        name: data['classroom']['name']
    );

    var weekDayNumber = data['week_day'];

    DayType weekDay;

    switch(weekDayNumber) {
      case 1:
        weekDay = DayType.monday;
        break;
      case 2:
        weekDay = DayType.tuesday;
        break;
      case 3:
        weekDay = DayType.wednesday;
        break;
      case 4:
        weekDay = DayType.thursday;
        break;
      case 5:
        weekDay = DayType.friday;
        break;
      case 6:
        weekDay = DayType.saturday;
        break;
      default:
        throw Exception("Invalid data");
    }

    var weekTypeNumber = data['week_type'];

    WeekType weekType;

    switch(weekTypeNumber) {
      case 1:
        weekType = WeekType.odd;
        break;
      case 2:
        weekType = WeekType.even;
        break;
      default:
        weekType = WeekType.both;
    }
    
    var datetime = DateTime.parse("1990-01-01 ${data['time']}");

    var time = Time(
        hours: datetime.hour,
        minutes: datetime.minute
    );

    var consultation = TeacherConsultation(
        id: data['id'],
        name: data['name'],
        day: weekDay,
        time: time,
        // teacher: teacher,
        weekType: weekType,
        weekDay: weekDay,
        building: building,
        cabinet: classroom
    );

    return consultation;
  }

  List<TeacherConsultation> parseFromJsonArray(List<dynamic> data) {
    var consultations = <TeacherConsultation>[];
    for(var element in data) {
      var consultation = parseFromJsonOne(element);
      consultations.add(consultation);
    }
    return consultations;
  }

}