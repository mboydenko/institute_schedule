import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/presentation/pages/teacher_selection/teacher_selection_vm.dart';
import 'package:institute_schedules/presentation/widgets/search_text_field_widget.dart';
import 'package:institute_schedules/presentation/widgets/spinner_with_label_widget.dart';
import 'package:institute_schedules/routing/router.gr.dart';
import 'package:provider/provider.dart';

import 'teacher_selection_vm.dart';

class TeacherSelectionPage extends StatelessWidget {
  const TeacherSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>TeacherSelectionVM(),
      child: _TeacherSelectionView(),
    );
  }
}

class _TeacherSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if(kDebugMode) {
      print("Rebuild _TeacherSelectionView");
    }

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            context.router.pop();
          }),
          title: const Text("Перподаватели"),
        ),
        body: _Body());
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TeacherSelectionVM>(context);

    if(kDebugMode) {
      print("Rebuild _TeacherSelectionView");
    }

    return Column(
      children: [Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(children: [
          SearchTextFieldWidget(
            backgroundColor: Colors.white,
            placeholder: "Преподаватель",
            onChanged: model.onFieldChanged,
          ),
          Visibility(
              child: const SizedBox(height: 2),
              visible: model.isLoadingCompleted || model.isLoading),
          Visibility(
            child: _Loading(),
            visible: model.isLoading,
          ),
          Visibility(
            visible: model.isLoadingCompleted && model.teachers.isEmpty,
            child: _NoTeachers(),
          ),
          Visibility(
              visible: model.isLoadingCompleted && model.teachers.isNotEmpty,
              child: _TeacherList()
          ),
        ]))],
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(kDebugMode) {
      print("Build _Loading widget");
    }
    return Container(
      height: 150,
      color: Colors.white,
      child: const Center(
        child: SpinnerWithLabelWidget(
          text: "Поиск",
          layout: SpinnerWithLabelWidgetLayout.spinnerTop,
          // textStyle: TextStyle(
          //   fontSize: 16
          // ),
        )
      )
    );
  }
}

class _TeacherList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model =
        Provider.of<TeacherSelectionVM>(context, listen: false);

    if(kDebugMode) {
      print("Build _TeacherList widget");
      print("Teacher count ${model.teachers.length}");
    }

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(child: getColumn(
          model.teachers,
          onClick: (teacher) {
            context.router.push(TeacherInformationRoute(teacher: teacher));
          }
      )),
    );
  }

  Column getColumn(List<Teacher> teachers,{ required Function(Teacher) onClick }) {
    var widgets = <Widget>[];

    for (var teacher in teachers) {
      widgets.add(
        GestureDetector(
          onTap: () => onClick(teacher),
          child: _TeacherWidget(teacher: teacher),
        )
      );

      if (teacher != teachers.last) {
        widgets.add(Container(height: 1, color: Colors.black));
      }
    }

    return Column(children: widgets);
  }
}

class _NoTeachers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: const Center(
        child: Text("Ничего не найдено", style: TextStyle(
            fontSize: 16
        ))
      ),
    );
  }
}

class _TeacherWidget extends StatelessWidget {
  final Teacher teacher;

  const _TeacherWidget({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(kDebugMode) {
      print("Build _Teacher widget");
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        teacherTitle(),
        const SizedBox(height: 5),
        chairBlock(),
      ]),
    );
  }

  Widget chairBlock() {
    return infoBlock(
        "Кафедра", teacher.chair != null ? teacher.chair!.abbreviation : "");
  }

  Widget teacherTitle() {
    return Text(teacher.lastNameWithInitials);
  }

  Widget infoBlock(String name, String value) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Text("$name:"), const SizedBox(width: 10), Text(value)]);
  }
}
