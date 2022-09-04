import 'chair.dart';

class Teacher {
  int id;
  String middleName;
  String firstName;
  // Institute? institute;
  Chair? chair;
  String lastName;
  String? email;

  Teacher(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.middleName,
      // this.institute,
      this.chair,
      this.email
  });

  String get lastNameWithInitials {
    return "$lastName ${firstName[0]}.${middleName[0]}.";
  }
}
