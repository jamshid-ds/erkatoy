import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';

class SingleChildScrollWithSize extends StatelessWidget {
  const SingleChildScrollWithSize({
    super.key,
    this.padding,
    this.screenWithAppBar = false,
    required this.statusBarHeight,
    required this.child,
  });

  final EdgeInsetsGeometry? padding;
  final bool screenWithAppBar;
  final double statusBarHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight:
              1.screenHeight(context) - statusBarHeight - (screenWithAppBar ? kToolbarHeight : 0),
          minWidth: 1.screenWidth(context),
        ),
        child: IntrinsicHeight(child: child),
      ),
    );
  }
}
