import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:institute_schedules/domain/schedules/entities/group.dart';
import 'package:institute_schedules/domain/schedules/interfaces/group_repository.dart';

class ApiGroupRepository extends GroupRepository {
  final apiUrl =  "${dotenv.env['API_URL']}/groups";

  @override
  Future<Group> getGroupById(int id) async {
    // TODO: implement getGroupsByPathOfName
    throw UnimplementedError();
  }

  @override
  Future<List<Group>> getGroupsByPathOfName(String pathOfName) async {
    var url = Uri.parse(apiUrl);

    var httpResponse = await http.get(url);

    var jsonResponse = convert.jsonDecode(
        convert.utf8.decode(httpResponse.bodyBytes)
    ) as List<dynamic>;

    var groups = <Group>[];

    for (Map<String, dynamic> element in jsonResponse) {
      var name = element['name'] as String;

      var groupName = name.toLowerCase();

      var searchName = pathOfName.toLowerCase();

      if (groupName.contains(searchName)) {

        var numberOfSubgroups = element['number_of_subgroups'] as int;

        var id = element['id'] as int;

        var group = Group(
          name: name,
          id: id,
          numberOfSubgroups: numberOfSubgroups
        );

        groups.add(group);
      }
    }

    return groups;
  }
}
