import 'package:flutter/cupertino.dart';

class CustomNativeSplash {
  CustomNativeSplash._();

  static WidgetsBinding? _widgetsBinding;

  static void preserve({
    required WidgetsBinding widgetsBinding,
  }) {
    _widgetsBinding = widgetsBinding;
    _widgetsBinding?.deferFirstFrame();
  }

  static void remove() {
    _widgetsBinding?.allowFirstFrame();
    _widgetsBinding = null;
  }
}
