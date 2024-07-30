import 'package:flutter/services.dart';

class DateTimeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = newValue.text;
    final int length = newText.length;

    // final String day = newText.

    return newValue;
  }
}
