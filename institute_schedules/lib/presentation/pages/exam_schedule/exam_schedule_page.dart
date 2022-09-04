import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:institute_schedules/presentation/widgets/card_widget.dart';
import 'package:institute_schedules/presentation/widgets/spinner_with_label_widget.dart';
import 'package:provider/provider.dart';
import 'exam_schedule_vm.dart';
import 'widgets/exam_widget.dart';

class ExamSchedulePage extends StatelessWidget {
  const ExamSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExamScheduleVM(),
      child: _ExamSchedulePage(),
    );
  }
}

class _ExamSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ExamScheduleVM>(context, listen: false);
    return Scaffold(appBar: getAppBar(model), body: _Body());
  }

  AppBar getAppBar(ExamScheduleVM model) {
    return AppBar(
      title: const Text("Раписание экзаменов"),
      actions: [
        IconButton(
            onPressed: () {
              model.onUpdateButtonClicked();
            },
            icon: const Icon(Icons.update_rounded))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ExamScheduleVM>(context);
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(15),
          child: model.isLoading
              ? _Loading()
              : model.exams.isNotEmpty
                  ? _ExamList()
                  : _NoLessonsWidget()),
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

class _ExamList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ExamScheduleVM>(context, listen: false);

    final widgets = <Widget>[];

    for (var exam in model.exams) {
      widgets.add(ExamWidget(exam: exam));
      if (exam != model.exams.last) {
        widgets.add(const SizedBox(height: 20));
      }
    }
    return Column(
      children: widgets,
    );
  }
}

class _NoLessonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CardWidget(
        body: Container(
            // color: Colors.white,
            height: 150,
            child: Center(
                child: Text("Информация отсутсвует",
                    style: TextStyle(color: Colors.white, fontSize: 18)))));
  }
}
