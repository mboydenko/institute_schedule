import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:institute_schedules/domain/schedules/entities/chair.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/interfaces/teacher_repository.dart';



class ApiTeacherRepository extends TeacherRepository {
  final apiUrl =  "${dotenv.env['API_URL']}/teachers";

  @override
  Future<Teacher> getTeacherById(int teacherId) async {
    var url = Uri.parse("$apiUrl/$teacherId");

    var response = await http.get(url);

    var jsonResponse =
        convert.jsonDecode(
            convert.utf8.decode(response.bodyBytes)
        ) as Map<String, dynamic>;

    var id = jsonResponse['id'];
    var firstName = jsonResponse['first_name'];
    var lastName = jsonResponse['last_name'];
    var middleName = jsonResponse['middle_name'];
    var email = jsonResponse['email'];

    var chairItem = jsonResponse['chair'] as Map<String, dynamic>;
    var chairId = chairItem['id'];
    var chairName = chairItem['name'];
    var chairAbbreviation = chairItem['abbreviation'];

    var teacher = Teacher(
        id: id,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        email: email,
        chair: Chair(
            id: chairId,
            name: chairName,
            abbreviation: chairAbbreviation,
            teachers: []));

    return teacher;
  }

  @override
  Future<List<Teacher>> getTeachersByPathOfName(String pathOfName) async {
    var url = Uri.parse(apiUrl);

    var response = await http.get(url);

    var jsonResponse = convert.jsonDecode(
        convert.utf8.decode(response.bodyBytes)
    ) as List<dynamic>;

    var result = <Teacher>[];

    for (var i = 0; i < jsonResponse.length; i++) {
      var item = jsonResponse[i] as Map<String, dynamic>;

      var id = item['id'];
      var firstName = item['first_name'];
      var lastName = item['last_name'];
      var middleName = item['middle_name'];
      var email = item['email'];

      var chairItem = item['chair'] as Map<String, dynamic>;
      var chairId = chairItem['id'];
      var chairName = chairItem['name'];
      var chairAbbreviation = chairItem['abbreviation'];

      var teacher = Teacher(
          id: id,
          firstName: firstName,
          lastName: lastName,
          middleName: middleName,
          email: email,
          chair: Chair(
              id: chairId,
              name: chairName,
              abbreviation: chairAbbreviation,
              teachers: []));

      String teacherName = teacher.lastName.toLowerCase();

      String searchName = pathOfName.toLowerCase();

      if (teacherName.contains(searchName)) {
        result.add(teacher);
      }
    }
    return result;
  }
}
