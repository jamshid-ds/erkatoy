import 'package:flutter/material.dart';

import 'google_font_style.dart';

class TextView extends StatelessWidget {
  const TextView({
    super.key,
    required this.text,
    this.textSize,
    this.textColor,
    this.textOverflow,
    this.maxLines,
    this.textAlign,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
  });

  const TextView.boldStyle({
    super.key,
    required this.text,
    this.textSize,
    this.textColor,
    this.textOverflow,
    this.maxLines,
    this.textAlign,
    this.fontFamily,
  })  : fontWeight = FontWeight.bold,
        fontStyle = null;

  final String text;
  final double? textSize;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final Color? textColor;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) => Text(
        text,
        overflow: textOverflow,
        maxLines: maxLines,
        style: googleFontStyle(
          font: fontFamily,
          fontSize: textSize,
          fontColor: textColor,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
        ),
        textAlign: textAlign,
      );
}
