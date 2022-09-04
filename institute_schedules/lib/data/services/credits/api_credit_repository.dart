import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:institute_schedules/domain/schedules/entities/building.dart';
import 'package:institute_schedules/domain/schedules/entities/class_room.dart';
import 'package:institute_schedules/domain/schedules/entities/group.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/entities/credit.dart';
import 'package:institute_schedules/domain/schedules/entities/date.dart';
import 'package:institute_schedules/domain/schedules/entities/discipline.dart';
import 'package:institute_schedules/domain/schedules/entities/exam.dart';
import 'package:institute_schedules/domain/schedules/entities/time.dart';
import 'package:institute_schedules/domain/schedules/interfaces/credit_repository.dart';
import 'package:institute_schedules/domain/schedules/interfaces/exam_repository.dart';

class ApiCreditRepository extends CreditRepository {
  final apiUrl =  "${dotenv.env['API_URL']}/credits";

  @override
  Future<List<Credit>> getCreditsByGroupId(int id) async {
    var url = Uri.parse("$apiUrl?group_id=$id");

    var response = await http.get(url);

    var jsonResponse =
    convert.jsonDecode(
        convert.utf8.decode(response.bodyBytes)
    ) as List<dynamic>;

    return parseFromJsonArray(jsonResponse);
  }

  @override
  Future<List<Credit>> getCreditsByTeacherId(int id) async {
    var url = Uri.parse("$apiUrl?group_id=$id");

    var response = await http.get(url);

    var jsonResponse =
    convert.jsonDecode(
        convert.utf8.decode(response.bodyBytes)
    ) as List<dynamic>;

    return parseFromJsonArray(jsonResponse);
  }

  List<Credit> parseFromJsonArray(List<dynamic> data) {

    var credits = <Credit>[];

    for(var element in data) {

      var credit = parseFromJsonOne(element);

      credits.add(credit);
    }

    return credits;
  }

  Credit parseFromJsonOne(Map<String, dynamic> data) {
    var teacher = Teacher(
        id: data['teacher']['id'],
        firstName: data['teacher']['first_name'],
        lastName: data['teacher']['last_name'],
        middleName: data['teacher']['middle_name']
    );

    var group = Group(
        id: data['group']['id'],
        numberOfSubgroups: data['group']['number_of_subgroups'],
        name: data['group']['name']
    );

    var discipline = Discipline(
        name: data['discipline']['name'],
        id: data['discipline']['id']
    );

    var building = Building(
        id: data['id'],
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

    Credit credit = Credit(
        id: data['id'],
        teacher: teacher,
        group: group,
        date: date,
        time: time,
        discipline: discipline,
        building: building,
        classRoom: classroom,
        subgroupNumber: data['subgroup_number']
    );

    return credit;
  }
}