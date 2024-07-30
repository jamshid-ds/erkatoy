import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';

class ErkatoyButton extends StatelessWidget {
  const ErkatoyButton({
    super.key,
    required this.onPressed,
    this.buttonWidth,
    this.buttonHeight,
    this.buttonColor,
    required this.text,
    this.textColor,
    this.textSize,
    this.borderRadius = 12,
    this.removeSplash = false,
    this.textToLeft = false,
  })  : isOutlined = false,
        borderSideColor = null;

  const ErkatoyButton.outlined({
    super.key,
    this.buttonWidth,
    this.buttonHeight,
    required this.onPressed,
    required this.text,
    this.textColor,
    this.textSize,
    this.borderRadius = 12,
    this.borderSideColor,
    this.removeSplash = false,
    this.textToLeft = false,
  })  : isOutlined = true,
        buttonColor = null;

  final VoidCallback? onPressed;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? buttonColor;
  final String text;
  final Color? textColor;
  final double? textSize;
  final double borderRadius;
  final bool isOutlined;
  final Color? borderSideColor;
  final bool removeSplash;
  final bool textToLeft;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      disabledColor: context.themeColors.onSurface.withOpacity(0.4),
      disabledTextColor: context.themeColors.surface,
      highlightElevation: removeSplash ? 0 : null,
      elevation: removeSplash ? 0 : null,
      minWidth: buttonWidth,
      height: buttonHeight,
      color: isOutlined ? context.themeColors.surface : buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: isOutlined ? BorderSide(color: borderSideColor ?? Colors.grey) : BorderSide.none,
      ),
      child: Align(
        alignment: textToLeft ? Alignment.centerLeft : Alignment.center,
        child: TextView(text: text, textColor: textColor, textSize: textSize),
      ),
    );
  }
}
