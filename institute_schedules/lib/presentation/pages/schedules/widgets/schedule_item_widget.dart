import 'package:flutter/material.dart';
import 'package:institute_schedules/domain/schedules/entities/building.dart';
import 'package:institute_schedules/domain/schedules/entities/class_room.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/domain/schedules/entities/time.dart';
import 'package:institute_schedules/domain/users/models/user.dart';

import '../../../widgets/schedule_item_type_widget.dart';

import '../entities/schedule_item.dart';

class ScheduleItemWidget extends StatelessWidget {
  final ScheduleItem item;
  final UserType userType;

  const ScheduleItemWidget(
      {Key? key, required this.item, required this.userType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                child: Column(children: [
              Row(children: [_ScheduleItemType(item.type)]),
              const SizedBox(height: 10),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _Time(startTime: item.startTime, endTime: item.endTime),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      _LessonName(item.discipline.name),
                      const SizedBox(height: 5),
                      Visibility(
                          visible: userType == UserType.teacher,
                          child: _GroupList(scheduleItemGroups: item.groups)),
                      Visibility(
                          visible: userType == UserType.student,
                          child: _TeacherList(teachers: item.teachers)),
                      const SizedBox(height: 5),
                      _Building(
                        building: item.building,
                      ),
                      const SizedBox(height: 5),
                      _ClassRoom(classRoom: item.classRoom)
                    ]))
              ])
            ])),
            const SizedBox(width: 30),
            const _DetailsWidget()
          ],
        ));
  }
}

class _Time extends StatelessWidget {
  final Time startTime;

  final Time? endTime;

  const _Time({Key? key, required this.startTime, this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startTimeMinutes = startTime.minutes > 9
        ? startTime.minutes.toString()
        : "0${startTime.minutes}";

    final endTimeMinutes = endTime == null
        ? ""
        : endTime!.minutes > 9
            ? endTime!.minutes.toString()
            : "0${endTime!.minutes}";

    final _startTime = "${startTime.hours}:$startTimeMinutes";

    final _endTime = endTime == null ? "" : "${endTime!.hours}:$endTimeMinutes";

    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text("$_startTime",
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 14,
          )),
      const SizedBox(height: 2),
      Text(
        "$_endTime",
        style: const TextStyle(
            color: Color.fromRGBO(90, 90, 90, 1),
            fontWeight: FontWeight.normal,
            fontSize: 12,
            fontFamily: 'Roboto'),
      )
    ]);
  }
}

class _LessonName extends StatelessWidget {
  final String name;

  const _LessonName(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      softWrap: false,
      style: const TextStyle(
          fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class _ScheduleItemType extends StatelessWidget {
  final ScheduleItemType type;

  const _ScheduleItemType(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScheduleItemTypeWidget widget;

    switch (type) {
      case ScheduleItemType.practice:
        widget = const PracticeTypeWidget();
        break;
      case ScheduleItemType.lecture:
        widget = const LectureTypeWidget();
        break;
      case ScheduleItemType.laboratoryWork:
        widget = const LaboratoryTypeWorkWidget();
        break;
      case ScheduleItemType.consultation:
        widget = const ConsultationTypeWidget();
        break;
      case ScheduleItemType.exam:
        widget = const ExamTypeWidget();
        break;
      case ScheduleItemType.credit:
        widget = const CreditTypeWidget();
        break;
      case ScheduleItemType.coursework:
        widget = const CourseWorkTypeWidget();
        break;
      default:
        throw Exception("Invalid schedule item type");
    }
    return widget;
  }
}

class _TeacherList extends StatelessWidget {
  final List<Teacher> teachers;

  const _TeacherList({Key? key, required this.teachers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String result = "";

    result += teachers[0].lastNameWithInitials;

    for (int i = 1; i < teachers.length; i++) {
      result += ", ${teachers[i].lastNameWithInitials}";
    }

    return Text(
      result,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: false,
      style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(71, 71, 71, 1)),
    );
  }
}

class _GroupList extends StatelessWidget {
  final List<ScheduleItemGroup> scheduleItemGroups;

  const _GroupList({Key? key, required this.scheduleItemGroups})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String result = "";

    if (scheduleItemGroups[0].subgroupNumber > 0) {
      result +=
          "${scheduleItemGroups[0].group.name} (${scheduleItemGroups[0].subgroupNumber} подгруппа)";
    } else {
      result += scheduleItemGroups[0].group.name;
    }

    for (int i = 1; i < scheduleItemGroups.length; i++) {
      if (scheduleItemGroups[i].subgroupNumber > 0) {
        result +=
            ", ${scheduleItemGroups[i].group.name} (${scheduleItemGroups[0].subgroupNumber} подгруппа)";
      } else {
        result += ", ${scheduleItemGroups[i].group.name}";
      }
    }

    return Text(
      result,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: false,
      style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(71, 71, 71, 1)),
    );
  }
}

class _Building extends StatelessWidget {
  final Building building;

  const _Building({Key? key, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Корпус: ${building.shortName}",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: false,
      style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(71, 71, 71, 1)),
    );
  }
}

class _ClassRoom extends StatelessWidget {
  final ClassRoom classRoom;

  const _ClassRoom({Key? key, required this.classRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Аудитория: ${classRoom.name}",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: false,
      style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(71, 71, 71, 1)),
    );
  }
}

class _DetailsWidget extends StatelessWidget {
  const _DetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.arrow_right_sharp, color: Colors.black);
  }
}
