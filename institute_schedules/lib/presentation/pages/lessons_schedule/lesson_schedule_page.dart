import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:institute_schedules/domain/schedules/entities/day.dart';
import 'package:institute_schedules/domain/schedules/entities/week.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

import 'lesson_schedule_vm.dart';
import 'widgets/week_tabs.dart';
import 'widgets/day_schedule.dart';

class LessonSchedulePage extends StatelessWidget {
  const LessonSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LessonScheduleVM(),
      child: _LessonSchedulePage(),
    );
  }
}

class _LessonSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: _Body(),
    );
  }
  
  AppBar getAppBar(BuildContext context) {
    final model = Provider.of<LessonScheduleVM>(context, listen: false);
    return AppBar(
      leading: BackButton(onPressed: (){
        context.router.pop();
      }),
      title: const Text("Расписание занятий"),
      actions: [
        IconButton(onPressed: (){
          model.onUpdateButtonClick();
        }, icon: const Icon(Icons.update))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height - 150.5;
    return WeekTabs(
        oddWeekBody: SingleChildScrollView(
          child: CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1
            ),
            items: const [
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                    weekType: WeekType.odd,
                    dayType: DayType.monday
                  )
              ),
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                      dayType: DayType.tuesday,
                      weekType:  WeekType.odd
                  )
              ),
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                      dayType: DayType.wednesday,
                      weekType:  WeekType.odd
                  )
              ),
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                      dayType: DayType.thursday,
                      weekType:  WeekType.odd
                  )
              ),
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                      dayType: DayType.friday,
                      weekType:  WeekType.odd
                  )
              ),
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                      dayType: DayType.saturday,
                      weekType:  WeekType.odd
                  )
              )
            ],
          ),
        ),
        evenWeekBody: SingleChildScrollView(
          child: CarouselSlider(
              options: CarouselOptions(
                  height: height,
                  viewportFraction: 1
              ),
            items: const [
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                      weekType: WeekType.even,
                      dayType: DayType.monday
                  )
              ),
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                      dayType: DayType.tuesday,
                      weekType:  WeekType.even
                  )
              ),
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                      dayType: DayType.wednesday,
                      weekType:  WeekType.even
                  )
              ),
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                      dayType: DayType.thursday,
                      weekType:  WeekType.even
                  )
              ),
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                      dayType: DayType.friday,
                      weekType:  WeekType.even
                  )
              ),
              _DayScheduleContainer(
                  daySchedule: DaySchedule(
                      dayType: DayType.saturday,
                      weekType:  WeekType.even
                  )
              )
            ]
          ),
        )
    );
  }
}

class _DayScheduleContainer extends StatelessWidget {
  final DaySchedule daySchedule;

  const _DayScheduleContainer({Key? key, required this.daySchedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: daySchedule,
      ),
    );
  }
}