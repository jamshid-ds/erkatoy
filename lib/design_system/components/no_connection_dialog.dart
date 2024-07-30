import 'dart:ui';

import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/core/constants/images_constants.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';

final noConnectionDialogKey = GlobalKey();

class NoConnectionDialog extends StatelessWidget {
  const NoConnectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: getBorderAll12),
          title: Column(
            children: [
              Image.asset(
                ImagesConstants.noConnectionPng,
                fit: BoxFit.cover,
                width: 64,
                height: 64,
              ),
              getHeightSize10,
              TextView(
                text: 'Tarmoq bilan aloqa yo`q!',
                textSize: 20.textSize(context),
                textColor: context.themeColors.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
