import 'package:flutter/cupertino.dart';
import 'package:institute_schedules/domain/schedules/entities/teacher_consultation.dart';
import 'consultation_widget.dart';

class ConsultationListWidget extends StatelessWidget {
  final List<TeacherConsultation> consultations;

  const ConsultationListWidget({Key? key, required this.consultations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    for(var consultation in consultations) {
        widgets.add(ConsultationWidget(teacherConsultation: consultation));
        if(consultation != consultations.last) {
          widgets.add(const SizedBox(height: 10));
        }
    }
    return Column(children: widgets);
  }
}