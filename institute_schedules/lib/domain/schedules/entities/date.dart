class Date {
  final int year;
  final int month;
  final int day;

  Date({required this.day, required this.month, required this.year});

  DateTime get toDateTime {
    return DateTime(year, month, day);
  }

  @override
  String toString() {
    String dayStr = day > 9 ? day.toString() : "0$day";
    String monthStr = month > 9 ? month.toString() : "0$month";
    return "$dayStr.$monthStr.$year";
  }
}
