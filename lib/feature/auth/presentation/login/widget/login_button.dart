
import 'package:erkatoy_afex_ai/design_system/components/erkatoy_button.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ErkatoyButton(
      onPressed: onPressed,
      text: 'Kirish',
      buttonHeight: 48,
      buttonColor: context.themeColors.primary,
      textColor: context.themeColors.onPrimary,
      textSize: 16.textSize(context),
    );
  }
}