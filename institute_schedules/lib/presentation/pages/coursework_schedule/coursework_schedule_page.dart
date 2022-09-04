import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:institute_schedules/domain/schedules/entities/coursework.dart';
import 'package:provider/provider.dart';

import '../../widgets/card_widget.dart';
import '../../widgets/spinner_with_label_widget.dart';
import 'widgets/coursework_widget.dart';
import 'coursework_schedule_vm.dart';

class CourseworkSchedulePage extends StatelessWidget {
  const CourseworkSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseworkScheduleVM(context),
      child: _CourseworkScheduleView(),
    );
  }
}

class _CourseworkScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = context.watch<CourseworkScheduleVM>();
    return Scaffold(
      appBar: getAppBar(model),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(15),
            child: model.isLoading
                ? _Loading()
                : model.coursworks.isNotEmpty
                    ? _CourseworkList(courseworks: model.coursworks)
                    : _NoCourseworksWidget()),
      ),
    );
  }

  AppBar getAppBar(CourseworkScheduleVM model) {
    return AppBar(
      leading: BackButton(
        onPressed: () => model.onBackButtonClick(),
      ),
      actions: [
        IconButton(
            onPressed: () => model.onUpdateButtonClick(),
            icon: const Icon(Icons.update_rounded))
      ],
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CardWidget(
        body: Container(
      // color: Colors.white,
      padding: EdgeInsets.all(15),
      height: 150,
      child: const Center(
        // child: Text("Загрузка расписания...",
        //     style: TextStyle(color: Colors.white, fontSize: 18)),
        child: SpinnerWithLabelWidget(
            text: "Загрузка расписания...",
            layout: SpinnerWithLabelWidgetLayout.spinnerTop,
            textStyle: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    ));
  }
}

class _CourseworkList extends StatelessWidget {
  final List<Coursework> courseworks;

  const _CourseworkList({Key? key, required this.courseworks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    for (var coursework in courseworks) {
      widgets.add(CourseworkWidget(coursework: coursework));
      if (coursework != courseworks.last) {
        widgets.add(const SizedBox(height: 20));
      }
    }
    return Column(
      children: widgets,
    );
  }
}

class _NoCourseworksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CardWidget(
        body: const SizedBox(
            // color: Colors.white,
            height: 150,
            child: Center(
                child: Text("Информация отсутсвует",
                    style: TextStyle(color: Colors.white, fontSize: 18)))));
  }
}
