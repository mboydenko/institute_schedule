import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:institute_schedules/domain/schedules/entities/date.dart';
import 'package:institute_schedules/domain/users/models/user.dart';
import 'package:institute_schedules/presentation/pages/schedules/entities/schedule_item.dart';
import 'package:institute_schedules/presentation/pages/schedules/schedules_page_vm.dart';
import 'package:institute_schedules/presentation/pages/schedules/widgets/schedule_item_widget.dart';
import 'package:institute_schedules/presentation/widgets/card_widget.dart';
import 'package:institute_schedules/presentation/widgets/spinner_with_label_widget.dart';
import 'package:provider/provider.dart';

class ScheduleWidget extends StatelessWidget {
  final List<ScheduleItem> items;

  final Function(ScheduleItem lesson) onItemClick;

  final Date date;

  final UserType userType;

  const ScheduleWidget(
      {Key? key,
      required this.items,
      required this.date,
      required this.userType,
      required this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SchedulesVM>(context);

    DateTime dateTime = DateTime(date.year, date.month, date.day);
    String weekDay = dateTime.weekday == 1
        ? "ПОНЕДЕЛЬНИК"
        : dateTime.weekday == 2
        ? "ВТОРНИК"
        : dateTime.weekday == 3
        ? "СРЕДА"
        : dateTime.weekday == 4
        ? "ЧЕТВЕРГ"
        : dateTime.weekday == 5
        ? "ПЯТНИЦА"
        : dateTime.weekday == 6
        ? "СУББОТА"
        : "ВОСКРЕСЕНИЕ";
    String month = dateTime.month == 1
        ? "ЯНВАРЯ"
        : dateTime.month == 2
        ? "ФЕВРАЛЯ"
        : dateTime.month == 3
        ? "МАРТА"
        : dateTime.month == 4
        ? "АПРЕЛЯ"
        : dateTime.month == 5
        ? "МАЯ"
        : dateTime.month == 6
        ? "ИЮНЯ"
        : dateTime.month == 7
        ? "ИЮЛЯ"
        : dateTime.month == 8
        ? "АВГУСТА"
        : dateTime.month == 9
        ? "СЕНТЯБРЯ"
        : dateTime.month == 10
        ? "ОКТЯБРАЯ"
        : dateTime.month == 11
        ? "НОЯБРЯ"
        : "ДЕКАБРЯ";

    return CardWidget(
        title: "$weekDay ${dateTime.day} $month",
        body: _ScheduleBody(
            userType: model.userType,
            loading: model.isLoading,
            onClick: onItemClick,
            items: items
        ));
  }
}

class _ScheduleBody extends StatelessWidget {
  bool loading;
  List<ScheduleItem> items;
  UserType userType;
  Function(ScheduleItem) onClick;

  _ScheduleBody({
    Key? key,
    required this.items,
    required this.loading,
    required this.userType,
    required this.onClick
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(kDebugMode) {
      print("Schedule body is rendering");
      print(items);
    }

    if(loading) {
      return const SizedBox(
        height: 150,
        child: Center(
            child: SpinnerWithLabelWidget(
              text: "Загрузка расписания",
              layout: SpinnerWithLabelWidgetLayout.spinnerTop,
              textStyle: TextStyle(fontSize: 18, color: Colors.white),
            )
        ),
      );
    }
    return items.isEmpty ? _NoLessonsWidget() : _ScheduleItemList(
        items: items,
        onClick: onClick,
        userType: userType
    );
  }

}

class _DateWidget extends StatelessWidget {
  final Date date;
  const _DateWidget({Key? key, required this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime(date.year, date.month, date.day);
    String weekDay = dateTime.weekday == 1
        ? "ПОНЕДЕЛЬНИК"
        : dateTime.weekday == 2
            ? "ВТОРНИК"
            : dateTime.weekday == 3
                ? "СРЕДА"
                : dateTime.weekday == 4
                    ? "ЧЕТВЕРГ"
                    : dateTime.weekday == 5
                        ? "ПЯТНИЦА"
                        : dateTime.weekday == 6
                            ? "СУББОТА"
                            : "ВОСКРЕСЕНИЕ";
    String month = dateTime.month == 1
        ? "ЯНВАРЯ"
        : dateTime.month == 2
            ? "ФЕВРАЛЯ"
            : dateTime.month == 3
                ? "МАРТА"
                : dateTime.month == 4
                    ? "АПРЕЛЯ"
                    : dateTime.month == 5
                        ? "МАЯ"
                        : dateTime.month == 6
                            ? "ИЮНЯ"
                            : dateTime.month == 7
                                ? "ИЮЛЯ"
                                : dateTime.month == 8
                                    ? "АВГУСТА"
                                    : dateTime.month == 9
                                        ? "СЕНТЯБРЯ"
                                        : dateTime.month == 10
                                            ? "ОКТЯБРАЯ"
                                            : dateTime.month == 11
                                                ? "НОЯБРЯ"
                                                : "ДЕКАБРЯ";
    return Text(
      "$weekDay ${dateTime.day} $month",
      style: const TextStyle(
          color: Colors.white, fontFamily: 'Roboto', fontSize: 14),
    );
  }
}

class _NoLessonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 150,
      child: Center(
        child: Text(
          "Занятий нет",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _ScheduleItemList extends StatelessWidget {
  final List<ScheduleItem> items;

  final Function(ScheduleItem) onClick;

  final UserType userType;

  const _ScheduleItemList(
      {Key? key,
      required this.items,
      required this.onClick,
      required this.userType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];

    for (var item in items) {
      widgets.add(
          GestureDetector(
            onTap: ()=> onClick(item),
            child: ScheduleItemWidget(item: item, userType: userType)
      )
    );

      if(item != items.last) {
        widgets.add(const SizedBox(
          height: 1
        ));
      }
    }
    return Column(children: widgets);
  }
}
