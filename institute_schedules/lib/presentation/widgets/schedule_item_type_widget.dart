import 'package:flutter/material.dart';

abstract class ScheduleItemTypeWidget extends StatelessWidget {
  final String title;
  final Color color;

  const ScheduleItemTypeWidget(
      {Key? key, required this.title, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 11, right: 11, top: 5, bottom: 5),
      child: Align(
          child: Text(title,
              style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w300))),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color),
    );
  }
}

class PracticeTypeWidget extends ScheduleItemTypeWidget {
  const PracticeTypeWidget()
      : super(title: "Практика", color: const Color.fromRGBO(49, 149, 77, 1));
}

class LaboratoryTypeWorkWidget extends ScheduleItemTypeWidget {
  const LaboratoryTypeWorkWidget()
      : super(
            title: "Лабораторная работа",
            color: const Color.fromARGB(255, 159, 2, 173));
}

class LectureTypeWidget extends ScheduleItemTypeWidget {
  const LectureTypeWidget()
      : super(title: "Лекция", color: const Color.fromRGBO(63, 163, 255, 1));
}

class ExamTypeWidget extends ScheduleItemTypeWidget {
  const ExamTypeWidget()
      : super(title: "Экзамен", color: const Color.fromRGBO(180, 0, 0, 1));
}

class CreditTypeWidget extends ScheduleItemTypeWidget {
  const CreditTypeWidget()
      : super(title: "Зачет", color: const Color.fromRGBO(38, 169, 161, 1));
}

class ConsultationTypeWidget extends ScheduleItemTypeWidget {
  const ConsultationTypeWidget()
      : super(
            title: "Консультация", color: const Color.fromRGBO(198, 63, 33, 1));
}

class CourseWorkTypeWidget extends ScheduleItemTypeWidget {
  const CourseWorkTypeWidget()
      : super(
            title: "Курсовая работа",
            color: const Color.fromARGB(255, 199, 32, 107));
}
