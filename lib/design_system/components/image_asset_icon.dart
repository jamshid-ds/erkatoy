import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageAssetIcon extends StatelessWidget {
  const ImageAssetIcon({super.key, required this.asset, this.color, this.iconSize});

  final String asset;
  final Color? color;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(asset),
      color: color,
      size: iconSize,
    );
  }
}
