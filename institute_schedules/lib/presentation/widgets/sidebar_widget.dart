import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:institute_schedules/presentation/widgets/application_icons.dart';
import 'package:institute_schedules/presentation/widgets/background_widget.dart';

class SidebarWidget extends StatelessWidget {
  final Function onChangeUserButtonClick;
  final Function onLessonScheduleButtonClick;
  final Function onExamScheduleButtonClick;
  final Function onCreditScheduleButtonClick;
  final Function onTeacherConsultationsButtonClick;
  final Function onAboutProgramButtonClick;
  final Function onCourseworkScheduleButtonClick;

  const SidebarWidget({
    Key? key,
    required this.onAboutProgramButtonClick,
    required this.onChangeUserButtonClick,
    required this.onCreditScheduleButtonClick,
    required this.onExamScheduleButtonClick,
    required this.onLessonScheduleButtonClick,
    required this.onTeacherConsultationsButtonClick,
    required this.onCourseworkScheduleButtonClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackgroundWidget(),
      Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              TextButton(
                  onPressed: () => onChangeUserButtonClick(),
                  child: const SizedBox(
                    height: 50,
                    width: 150,
                    child: Center(
                      child: Text(
                        "Сменить",
                        style: _TextStyle(),
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
        body: Container(
          color: const Color.fromRGBO(0, 0, 0, 0.8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                _Divider(),
                TextButton(
                  onPressed: () => onLessonScheduleButtonClick(),
                  child: _LessonScheduleSlot(),
                ),
                _Divider(),
                TextButton(
                  onPressed: () => onCreditScheduleButtonClick(),
                  child: _CreditScheduleSlot(),
                ),
                _Divider(),
                TextButton(
                  onPressed: () => onExamScheduleButtonClick(),
                  child: _ExamScheduleSlot(),
                ),
                _Divider(),
                TextButton(
                  onPressed: () => onCourseworkScheduleButtonClick(),
                  child: _CourseworkScheduleSlot(),
                ),
                _Divider(),
                TextButton(
                  onPressed: () => onTeacherConsultationsButtonClick(),
                  child: _TeacherConsultationsSlot(),
                ),
                _Divider(),
                Expanded(
                    child: Container()
                ),
                _Divider(),
                TextButton(
                    onPressed: () => onAboutProgramButtonClick(),
                    child: _AboutProgramSlot()
                ),
                _Divider(),
              ]
          ),
        ),
      )
    ]);

      Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            TextButton(
                onPressed: () => onChangeUserButtonClick(),
                child: const SizedBox(
                  height: 50,
                  width: 150,
                  child: Center(
                    child: Text(
                      "Сменить",
                      style: _TextStyle(),
                    ),
                  ),
                )
            )
          ],
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              _Divider(),
              TextButton(
                onPressed: () => onLessonScheduleButtonClick(),
                child: _LessonScheduleSlot(),
              ),
              _Divider(),
              TextButton(
                onPressed: () => onCreditScheduleButtonClick(),
                child: _CreditScheduleSlot(),
              ),
              _Divider(),
              TextButton(
                onPressed: () => onExamScheduleButtonClick(),
                child: _ExamScheduleSlot(),
              ),
              _Divider(),
              TextButton(
                onPressed: () => onCourseworkScheduleButtonClick(),
                child: _CourseworkScheduleSlot(),
              ),
              _Divider(),
              TextButton(
                onPressed: () => onTeacherConsultationsButtonClick(),
                child: _TeacherConsultationsSlot(),
              ),
              _Divider(),
              Expanded(
                  child: Container()
              ),
              _Divider(),
              TextButton(
                  onPressed: () => onAboutProgramButtonClick(),
                  child: _AboutProgramSlot()
              ),
              _Divider(),
            ]
        ),
      ),
    );
  }
}

class _Slot extends StatelessWidget {
  final IconData? icon;
  final String label;

  const _Slot({Key? key, required this.label, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];

    if (icon != null) {
      var _icon = Icon(icon, size: 30, color: Colors.white);
      widgets.add(_icon);
      widgets.add(const SizedBox(width: 10));
    }

    var text = Text(
      label,
      style: const _TextStyle(),
    );
    widgets.add(text);

    return Container(
      padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          // left: ,
          right: 5
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }
}

class _LessonScheduleSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _Slot(
        icon: Icons.schedule_outlined,
        label: "Расписание занятий"
    );
  }
}

class _CreditScheduleSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _Slot(
        icon: ApplicationIcons.credit,
        label: "Расписание зачетов"
    );
  }
}

class _ExamScheduleSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _Slot(
        icon: ApplicationIcons.exam,
        label: "Расписание экзаменов"
    );
  }
}

class _CourseworkScheduleSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _Slot(
        icon: ApplicationIcons.coursework,
        label: "Расписание курсовых работ"
    );
  }
}

class _TeacherConsultationsSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _Slot(
        icon: ApplicationIcons.teacherConsultation,
        label: "Консультации преподавателей"
    );
  }
}

class _AboutProgramSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _Slot(
        icon: ApplicationIcons.information,
        label: "О программе"
    );
  }

}

class _TextStyle extends TextStyle {
  const _TextStyle() : super(
      color: Colors.white,
      fontSize: 14
  );
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: Colors.white);
  }
}