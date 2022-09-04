import 'package:flutter/cupertino.dart';
import 'spinner_widget.dart';

enum SpinnerWithLabelWidgetLayout {
  spinnerLeft,
  spinnerTop,
  spinnerBottom,
  spinnerRight
}

class SpinnerWithLabelWidget extends StatelessWidget {
  final String text;

  final TextStyle? textStyle;

  final SpinnerWithLabelWidgetLayout layout;

  const SpinnerWithLabelWidget(
      {Key? key, this.textStyle, required this.text, required this.layout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(layout) {
      case SpinnerWithLabelWidgetLayout.spinnerLeft:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinnerWidget(),
            const SizedBox(width : 20),
            Text(text, style: textStyle)
          ],
        );
      case SpinnerWithLabelWidgetLayout.spinnerTop:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinnerWidget(),
            const SizedBox(height: 20),
            Text(text, style: textStyle)
          ],
        );
      case SpinnerWithLabelWidgetLayout.spinnerBottom:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: textStyle),
            const SizedBox(height: 20),
            SpinnerWidget(),
          ],
        );
      case SpinnerWithLabelWidgetLayout.spinnerRight:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: textStyle),
            const SizedBox(width : 20),
            SpinnerWidget(),
          ],
        );
    }
  }
}
