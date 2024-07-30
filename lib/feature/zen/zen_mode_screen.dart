import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:flutter/material.dart';

class ZenModeScreen extends StatefulWidget {
  const ZenModeScreen({super.key});

  static const String routeName = '/zen_mode';

  @override
  State<ZenModeScreen> createState() => _ZenModeScreenState();
}

class _ZenModeScreenState extends State<ZenModeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextView(text: 'Zen mode'),
      ),
    );
  }
}
