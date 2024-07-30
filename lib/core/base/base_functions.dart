import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';

void printOnDebug(Object? msg) {
  debugPrint("------------------\n$msg\n------------------");
}

/// sizedBoxes
SizedBox get getWidthSize4 => const SizedBox(width: 4);
SizedBox get getHeightSize4 => const SizedBox(height: 4);
SizedBox get getWidthSize6 => const SizedBox(width: 6);
SizedBox get getHeightSize6 => const SizedBox(height: 6);
SizedBox get getWidthSize8 => const SizedBox(width: 8);
SizedBox get getHeightSize8 => const SizedBox(height: 8);
SizedBox get getWidthSize10 => const SizedBox(width: 10);
SizedBox get getHeightSize10 => const SizedBox(height: 10);
SizedBox get getWidthSize12 => const SizedBox(width: 12);
SizedBox get getHeightSize12 => const SizedBox(height: 12);
SizedBox get getWidthSize16 => const SizedBox(width: 16);
SizedBox get getHeightSize16 => const SizedBox(height: 16);
SizedBox get getWidthSize20 => const SizedBox(width: 20);
SizedBox get getHeightSize20 => const SizedBox(height: 20);
SizedBox getFullHeight(BuildContext context) => SizedBox(height: 1.screenHeight(context));
SizedBox getFullWidth(BuildContext context) => SizedBox(width: 1.screenWidth(context));

/// edgeInsets
EdgeInsets get getPaddingAll4 => const EdgeInsets.all(4);
EdgeInsets get getPaddingAll6 => const EdgeInsets.all(6);
EdgeInsets get getPaddingAll8 => const EdgeInsets.all(8);
EdgeInsets get getPaddingAll10 => const EdgeInsets.all(10);
EdgeInsets get getPaddingAll16 => const EdgeInsets.all(16);
EdgeInsets get getPaddingAll20 => const EdgeInsets.all(20);
// EdgeInsets get symmetric => const EdgeInsets.symmetric(horizontal: );

/// borders
BorderRadius get getBorderAll8 => BorderRadius.circular(8);
BorderRadius get getBorderAll10 => BorderRadius.circular(10);
BorderRadius get getBorderAll12 => BorderRadius.circular(12);
BorderRadius get getBorderAll14 => BorderRadius.circular(14);
BorderRadius get getBorderAll16 => BorderRadius.circular(16);
BorderRadius get getBorderAll20 => BorderRadius.circular(20);
BorderRadius getFullBorder(BuildContext context) => BorderRadius.circular(1.screenWidth(context));
BorderRadius getCustomBorder(double radius) => BorderRadius.circular(radius);


/// dividers
Widget get getDivider => const Divider(color: Colors.grey);
Widget get getOpacityDivider => Divider(color: Colors.grey.withOpacity(0.5));


String dateTimeFormat(DateTime dateTime) {
  String day = dateTime.day.toString().length == 1 ? '0${dateTime.day}' : dateTime.day.toString();
  String month =
  dateTime.month.toString().length == 1 ? '0${dateTime.month}' : dateTime.month.toString();
  return '$day.$month.${dateTime.year}';
}
