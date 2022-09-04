import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:institute_schedules/domain/schedules/entities/day.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher_consultation.dart';
import 'package:institute_schedules/domain/schedules/entities/time.dart';
import 'package:institute_schedules/presentation/widgets/card_widget.dart';

class ConsultationWidget extends StatelessWidget {
  final TeacherConsultation teacherConsultation;

  const ConsultationWidget({Key? key, required this.teacherConsultation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title;

    switch (teacherConsultation.weekDay) {
      case DayType.monday:
        title = "ПОНЕДЕЛЬНИК";
        break;
      case DayType.tuesday:
        title = "ВТОРНИК";
        break;
      case DayType.wednesday:
        title = "СРЕДА";
        break;
      case DayType.thursday:
        title = "ЧЕТВЕРГ";
        break;
      case DayType.friday:
        title = "ПЯТНИЦА";
        break;
      case DayType.saturday:
        title = "СУББОТА";
        break;
    }

    return CardWidget(
        title: title,
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            _Title(title: teacherConsultation.name),
            const SizedBox(height: 8),
            _InfoLabel(
                title: "Корпус",
                label: teacherConsultation.building != null
                    ? teacherConsultation.building!.shortName
                    : ""),
            const SizedBox(height: 8),
            _InfoLabel(
                title: "Кабинет",
                label: teacherConsultation.cabinet != null
                    ? teacherConsultation.cabinet!.name
                    : ""),
            const SizedBox(height: 8),
            _InfoLabel(
                title: "Время", label: teacherConsultation.time.toString())
          ]),
        ));
  }
}

class _InfoLabel extends StatelessWidget {
  final String title;

  final String label;

  const _InfoLabel({Key? key, required this.title, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title:",
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 102, 255, 1))),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        )
      ],
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 18,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          color: Colors.red),
    );
  }
}
