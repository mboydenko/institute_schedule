import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidget extends StatelessWidget {
  final Function onBackClick;
  final Function onLessonsTimetableClick;
  final Function onOffsetsTimetableClick;
  final Function onTeacherConsultationTimetableClick;
  final Function onExamsTimetableClick;

  const DrawerWidget(
      {Key? key,
        required this.onLessonsTimetableClick,
        required this.onOffsetsTimetableClick,
        required this.onExamsTimetableClick,
        required this.onTeacherConsultationTimetableClick,
        required this.onBackClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container()),
      SafeArea(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: BackButton(onPressed: () {
                Navigator.pop(context);
              }),
              title: const Text("Расписания",
                  style: TextStyle(
                      fontSize: 18, fontFamily: 'Roboto', color: Colors.white)),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 10),
                child: Column(children: [
                  Container(height: 1, color: Colors.white),
                  TextButton(
                    onPressed: () => onLessonsTimetableClick(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 75,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/timetable_icon_50x50.svg',
                              height: 50, width: 50),
                          const SizedBox(width: 14),
                          const Text("Расписание занятий",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.white,
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Container(height: 1, color: Colors.white),
                  TextButton(
                    onPressed: () => onOffsetsTimetableClick(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 75,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/offset_icon_50x50.svg',
                              height: 50, width: 50),
                          const SizedBox(width: 14),
                          const Text("Расписание зачетов",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.white,
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Container(height: 1, color: Colors.white),
                  TextButton(
                    onPressed: () => onExamsTimetableClick(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 75,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/exam_icon_50x50.svg',
                              height: 50, width: 50),
                          const SizedBox(width: 14),
                          const Text("Расписание экзаменов",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.white,
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Container(height: 1, color: Colors.white),
                  TextButton(
                    onPressed: () => onTeacherConsultationTimetableClick(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 75,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                              'assets/images/teacher_consultation_icon_50x50.svg',
                              height: 50,
                              width: 50),
                          const SizedBox(width: 14),
                          const Text("Консультации преподавателей",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.white,
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Container(height: 1, color: Colors.white),
                ])),
          ))
    ]);
  }
}
