import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';

import 'google_font_style.dart';

class DifferentColoredRichText extends StatelessWidget {
  const DifferentColoredRichText({
    super.key,
    required this.leftText,
    required this.leftTextColor,
    required this.rightText,
    required this.rightTextColor,
    this.textSize,
  });

  final String leftText;
  final Color leftTextColor;
  final String rightText;
  final Color rightTextColor;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      child: RichText(
        text: TextSpan(
          text: leftText,
          style: googleFontStyle(
            fontColor: leftTextColor,
            fontSize: textSize ?? 14.textSize(context),
          ),
          children: <TextSpan>[
            TextSpan(
              text: rightText,
              style: googleFontStyle(
                fontColor: rightTextColor,
                fontSize: textSize ?? 14.textSize(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
