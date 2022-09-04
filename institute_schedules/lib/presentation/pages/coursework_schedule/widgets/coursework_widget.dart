import 'package:flutter/material.dart';
import 'package:institute_schedules/domain/schedules/entities/coursework.dart';
import 'package:institute_schedules/domain/schedules/entities/exam.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/presentation/widgets/card_widget.dart';
import 'package:institute_schedules/presentation/widgets/schedule_item_type_widget.dart';

class CourseworkWidget extends StatelessWidget {
  final Coursework coursework;

  const CourseworkWidget({Key? key, required this.coursework}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: "${coursework.date.toString()} ${coursework.time.toString()}",
      body: _Body(coursework: coursework),
    );
  }
}

class _Body extends StatelessWidget {
  final Coursework coursework;

  const _Body({Key? key, required this.coursework}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _Title(title: coursework.discipline.name),
                    const SizedBox(height: 8),
                    _InfoLabel(title: "Коммисия:", label: getCommission(coursework.commissionComposition)),
                    const SizedBox(height: 8),
                    _InfoLabel(title: "Корпус", label: coursework.building.shortName),
                    const SizedBox(height: 8),
                    _InfoLabel(title: "Аудитория", label: coursework.classRoom.name)
                  ],
                )
            ),
            const SizedBox(width: 30),
            const _DetailsWidget()
          ],
        )
    );
  }

  String getCommission(List<Teacher> teachers)  {
    var result = "";
    for(var teacher in teachers) {
      result += teacher.lastNameWithInitials + " ";
      if(teacher != teachers.last) {
        result += " ";
      }
    }
    return result;
  }
}

class _InfoLabel extends StatelessWidget {
  final String title;

  final String label;

  const _InfoLabel({Key? key, required this.title, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title:", style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 102, 255, 1)
        )),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.black
          ),
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
          color: Colors.red
      ),
    );
  }
}

class _ExamTypeWidget extends StatelessWidget {
  final ExamType type;

  const _ExamTypeWidget({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == ExamType.exam ? const ExamTypeWidget() : const ConsultationTypeWidget();
  }
}

class _DetailsWidget extends StatelessWidget {
  const _DetailsWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.arrow_right_sharp, color: Colors.black);
  }
}