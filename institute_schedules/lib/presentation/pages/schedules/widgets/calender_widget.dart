import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import '../schedules_page_vm.dart';

class CalendarWidget extends StatefulWidget {

  final SchedulesVM model;

  CalendarWidget({
    Key? key,
    required this.model,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() => _CalendarWidget();
}

class _CalendarWidget extends State<CalendarWidget> {

  @override
  void initState() {
    widget.model.addListener(onModelChanged);
    super.initState();
  }

  void onModelChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.model.removeListener(onModelChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            color: Colors.white,
            child: CalendarCarousel(
                locale: 'ru',
                width: 600,
                height: 300,
                selectedDayBorderColor: Colors.green,
                selectedDayTextStyle: TextStyle(
                    color: Colors.white
                ),
                todayBorderColor: Colors.green,
                todayButtonColor: Colors.white,
                todayTextStyle: const TextStyle(
                    color: Colors.yellow
                ),
                selectedDateTime: widget.model.calendarSelectedDate.toDateTime,
                onDayPressed: (dt,_) {
                  widget.model.onCalendarDateButtonClick(dt);
                },
              ),
    );
  }

}