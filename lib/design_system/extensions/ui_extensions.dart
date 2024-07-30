import 'package:flutter/material.dart';

extension ContextExts on BuildContext {
  ColorScheme get themeColors => Theme.of(this).colorScheme;
}

extension SizeUtil on num {
  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width * this;

  double screenHeight(BuildContext context) => MediaQuery.of(context).size.height * this;

  double textSize(BuildContext context) => MediaQuery.of(context).textScaler.scale(toDouble());
}
