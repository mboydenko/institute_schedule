class Time {
  final int hours;
  final int minutes;

  Time({required this.hours, required this.minutes});

  @override
  String toString() {
    String minutesStr = (minutes > 9) ? minutes.toString() : '0$minutes';
    return "$hours:$minutesStr";
  }
}