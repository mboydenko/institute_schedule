import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher.dart';
import 'package:institute_schedules/presentation/widgets/search_text_field_widget.dart';
import 'package:institute_schedules/presentation/widgets/spinner_with_label_widget.dart';
import 'package:provider/provider.dart';
import './user_teacher_profile_selection_vm.dart';

class UserTeacherProfileSelectionPage extends StatelessWidget {
  const UserTeacherProfileSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=>UserTeacherProfileSelectionVM(context),
        child: _UserTeacherSelectionPageView(),
    );
  }
}

class _UserTeacherSelectionPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Выбор профиля"),
      ),
      body: _Body(),
    );
  }
}


class _Body extends StatelessWidget {
@override
Widget build(BuildContext context) {
  final model = Provider.of<UserTeacherProfileSelectionVM>(context);

  if(kDebugMode) {
    print("User teacher profile selection page build");
  }

  return Column(
    children: [
      Container(
        margin: const EdgeInsets.all(15),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(children: [
          SearchTextFieldWidget(
            placeholder: "Преподаватель",
            backgroundColor: Colors.white,
            onChanged: model.onFieldChanged,
          ),
          Visibility(
              visible: model.isLoadingCompleted || model.isLoading,
              child: const SizedBox(height: 2)),
          Visibility(
            visible: model.isLoading,
            child: _Loading(),
          ),
          Visibility(
              visible: model.isLoadingCompleted && model.searchResult.isEmpty,
              child: _EmptyResult()),
          Visibility(
            visible:
            model.isLoadingCompleted && model.searchResult.isNotEmpty,
            child: _TeacherList(),
          ),
        ]),
      )
    ],
  );
}
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.white,
      child: const Center(
          child: SpinnerWithLabelWidget(
            layout: SpinnerWithLabelWidgetLayout.spinnerTop,
            text: "Поиск группы",
            textStyle: TextStyle(fontSize: 16),
          )),
    );
  }
}

class _EmptyResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 100,
      child: const Center(
        child: Text("Ничего не найдено", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}


class _TeacherList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<UserTeacherProfileSelectionVM>(context, listen: false);

    final widgets = <Widget>[];

    for(var teacher in model.searchResult) {
      if(teacher == model.searchResult.first) {
        var teacherWidget = GestureDetector(
            onTap: ()=> model.onTeacherClick(teacher),
            child: _TeacherWidget(teacher: teacher),
        );
        widgets.add(teacherWidget);
      }
      else {
        var divider = Container(height: 1, color: Colors.grey);
        var teacherWidget = GestureDetector(
          onTap: ()=> model.onTeacherClick(teacher),
          child: _TeacherWidget(teacher: teacher),
        );
        widgets.add(divider);
        widgets.add(teacherWidget);
      }
    }

    var list = Container(
      color: Colors.white,
      child:  Column(
          children: widgets,
        ),
      );
    return list;
  }
}

class _TeacherWidget extends StatelessWidget {
  final Teacher teacher;

  const _TeacherWidget({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(
        bottom: 5,
        top: 5,
        left: 10,
        right: 10
      ),
      child: Column(children: [
        Row(children: [
          Text(teacher.lastNameWithInitials)
        ]),
        const SizedBox(height: 5),
        Row(children: [
          const Text("Кафедра:"),
          const SizedBox(width: 10),
          Text(teacher.chair!.abbreviation)
        ])
      ]),
    );
  }
}