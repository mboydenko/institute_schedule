import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:institute_schedules/domain/schedules/constants/weeks.dart';
import 'package:institute_schedules/domain/schedules/entities/week.dart';
import 'package:institute_schedules/presentation/pages/schedules/widgets/calender_widget.dart';
import 'package:institute_schedules/presentation/pages/schedules/widgets/schedule_widget.dart';
import 'package:institute_schedules/presentation/widgets/background_widget.dart';
import 'package:institute_schedules/presentation/widgets/sidebar_widget.dart';
import 'package:institute_schedules/routing/router.gr.dart';
import 'schedules_page_vm.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// import 'widgets/calender_widget.dart';

class SchedulesPage extends StatelessWidget {
  const SchedulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SchedulesVM(context),
      child: _SchedulesView(),
    );
  }
}

class _SchedulesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SchedulesVM>(context);

    return Scaffold(
          drawerEdgeDragWidth: 0,
          endDrawer: Drawer(
            child: SidebarWidget(
              onTeacherConsultationsButtonClick: () {
                context.router.push(const TeacherConsultationsRoute());
              },
              onLessonScheduleButtonClick: () {
                context.router.push(const LessonScheduleRoute());
              },
              onExamScheduleButtonClick: () {
                context.router.push(const ExamScheduleRoute());
              },
              onCreditScheduleButtonClick: () {
                context.router.push(const CreditScheduleRoute());
              },
              onCourseworkScheduleButtonClick: () {
                context.router.push(const CourseworkScheduleRoute());
              },
              onChangeUserButtonClick: () {
                context.router.replaceAll([AuthRoute()]);
              },
              onAboutProgramButtonClick: () {},
            ),
          ),
          appBar: getAppBar(model, context),
          body: getBody(context, model),
          floatingActionButton: FloatingActionButton(
            onPressed: () => model.onUpdateButtonClick(),
            backgroundColor: Color.fromRGBO(31, 87, 105, 1),
            child:  const Icon(Icons.update_rounded),
          ),
          // bottomNavigationBar: getBottomNavigationWidget(context),
    );
  }

  AppBar getAppBar(SchedulesVM model, BuildContext context) {
    return AppBar(
      title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
            const SizedBox(height: 5),
            Text(
                model.weekType == WeekType.odd ? ODD_WEEK_NAME : EVEN_WEEK_NAME,
                style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.54),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300))
          ]),
      actions: [
        // IconButton(
        //     onPressed: () => provider.onUpdateButtonClick(),
        //     icon: const Icon(Icons.update_rounded)),
        IconButton(
            onPressed: (){
              _showCalendar(context, model);
            }, icon: const Icon(Icons.calendar_today_rounded)),
        Builder(builder: (context) {
          return IconButton(onPressed: () {
            Scaffold.of(context).openEndDrawer();
          }, icon: const Icon(Icons.more_horiz_rounded));
        })
      ],

    );
  }

  Widget getBody(BuildContext context, SchedulesVM model) {
    final double height = MediaQuery
        .of(context)
        .size
        .height;

    return CarouselSlider(
        options: CarouselOptions(
          initialPage: model.currentIndex,
          onPageChanged: (index, reason) => model.onCarouselChanged(index),
          height: height,
          viewportFraction: 1,
        ),
        items: [
          SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(15),
                child: ScheduleWidget(
                  date: model.dateIndex0,
                  items: model.scheduleIndex0,
                  onItemClick: model.onScheduleItemClick,
                  userType: model.userType,
                ),
              )), // index 0
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: ScheduleWidget(
                onItemClick: model.onScheduleItemClick,
                date: model.dateIndex1,
                items: model.scheduleIndex1,
                userType: model.userType,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(15),
                child: ScheduleWidget(
                  onItemClick: model.onScheduleItemClick,
                  date: model.dateIndex2,
                  items: model.scheduleIndex2,
                  userType: model.userType,
                )),
          )
        ]);
  }

  void _showCalendar(BuildContext context, SchedulesVM model) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: CalendarWidget(
            model: model,
          ),
          actions: [
            TextButton(onPressed: (){
              model.onCalendarCancelButtonClick();
              Navigator.of(context).pop();
            }, child: const Text("Отменить")),
            TextButton(onPressed: () {
              model.onCalendarOkButtonClick();
              Navigator.of(context).pop();
            }, child: const Text("Применить"))
          ],
        );
      }
    );
  }
}
