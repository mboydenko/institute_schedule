import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:institute_schedules/domain/schedules/constants/weeks.dart';

class WeekTabs extends StatefulWidget {
  final Widget oddWeekBody;
  final Widget evenWeekBody;

  const WeekTabs(
      {Key? key, required this.oddWeekBody, required this.evenWeekBody})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeekTabsState();
}

class _WeekTabsState extends State<WeekTabs> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TabBar(
          controller: tabController,
          tabs: const [Tab(text: ODD_WEEK_NAME), Tab(text: EVEN_WEEK_NAME)]),
      const SizedBox(
        height: 5,
      ),
      Expanded(
          child: TabBarView(
              controller: tabController,
              children: [widget.oddWeekBody, widget.evenWeekBody])
      )
    ]);
  }
}
