import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/design_system/components/different_colored_rich_text.dart';
import 'package:erkatoy_afex_ai/design_system/components/scale_on_press_button.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/login/login_screen.dart';
import 'package:flutter/material.dart';

class AlreadySignedTextButton extends StatelessWidget {
  const AlreadySignedTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleOnPress(
      child: InkWell(
        borderRadius: getBorderAll8,
        onTap: () {
          LoginScreen.open(context);
        },
        child: DifferentColoredRichText(
          leftText: 'Oldin ro`yxatdan o`tganmisiz? Profilga ',
          leftTextColor: context.themeColors.onSurface,
          rightText: 'Kirish!',
          rightTextColor: context.themeColors.primary,
        ),
      ),
    );
  }
}
