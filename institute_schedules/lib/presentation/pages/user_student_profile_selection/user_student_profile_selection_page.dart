import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:institute_schedules/presentation/pages/user_student_profile_selection/entities/group_wrapper.dart';
import 'package:institute_schedules/presentation/pages/user_student_profile_selection/user_student_profile_selection_vm.dart';
import 'package:institute_schedules/presentation/widgets/search_text_field_widget.dart';
import 'package:institute_schedules/presentation/widgets/spinner_with_label_widget.dart';
import 'package:provider/provider.dart';

class UserStudentProfileSelectionPage extends StatelessWidget {
  const UserStudentProfileSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserStudentProfileSelectionVM(context),
      child: _UserStudentProfileSelectionPage(),
    );
  }
}

class _UserStudentProfileSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: _Body(),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Выбор профиля"),
      leading: BackButton(onPressed: () {
        context.router.pop();
      }),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<UserStudentProfileSelectionVM>(context);

    if(kDebugMode) {
      print("User student profile selection page build");
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
              placeholder: "Группа",
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
                  child: _GroupList(),
                ),
          ]),
        )
      ],
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

class _GroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<UserStudentProfileSelectionVM>(context, listen: false);

    final widgets = <Widget>[];

    final groupWrappers = model.searchResult;

    for(var groupWrapper in groupWrappers) {
      widgets.add(
        GestureDetector(
          onTap: ()=> model.onGroupWrapperClick(groupWrapper),
          child: _GroupWidget(group: groupWrapper)
        )
      );

      if(groupWrapper != groupWrappers.last) {
        widgets.add(Container(height: 1, color: Colors.black));
      }
    }

    return Container(
        color: Colors.white,
        child: Column(
            children: widgets,
          ),
    );
  }
}

class _GroupWidget extends StatelessWidget {
  final GroupWrapper group;

  const _GroupWidget({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [Text(group.name)],
      ),
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
