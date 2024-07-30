import 'package:flutter/cupertino.dart';

class BirthDatePicker extends StatelessWidget {
  const BirthDatePicker({super.key, required this.initialDate, required this.onDateTimeChanged});

  final DateTime initialDate;
  final ValueChanged<DateTime> onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    return CupertinoDatePicker(
      onDateTimeChanged: onDateTimeChanged,
      mode: CupertinoDatePickerMode.date,
      dateOrder: DatePickerDateOrder.dmy,
      minimumYear: 2021,
      maximumYear: currentDate.year,
      initialDateTime: initialDate,
      use24hFormat: true,
    );
  }
}
