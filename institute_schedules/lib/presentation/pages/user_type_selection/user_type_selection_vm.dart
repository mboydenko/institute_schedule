import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:institute_schedules/routing/router.gr.dart';

class UserTypeSelectionVM extends ChangeNotifier {
  BuildContext context;

  UserTypeSelectionVM(this.context) : super();

  void onTeacherButtonClick() {
    context.pushRoute(const TeacherProfileSelectionRoute());
  }

  void onStudentButtonClick() {
    context.pushRoute(const StudentProfileSelectionRoute());
  }
}