import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/creating_account/creating_account_screen.dart';
import 'package:erkatoy_afex_ai/feature/change_lang/bloc/change_lang_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLangFloatingAcBtn extends StatelessWidget {
  const ChangeLangFloatingAcBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChangeLangBloc, ChangeLangState, String?>(
      selector: (state) => state.changedLocale,
      builder: (context, state) {
        return state != null
            ? FloatingActionButton.extended(
                onPressed: () {
                  // CreatingAccountScreen.open(context);
                },
                isExtended: true,
                shape: RoundedRectangleBorder(borderRadius: getBorderAll10),
                backgroundColor: context.themeColors.primary,
                label: TextView(
                  text: 'Davom Etish',
                  textSize: 16.textSize(context),
                  textColor: context.themeColors.onPrimary,
                ),
                icon: Icon(Icons.done_rounded, color: context.themeColors.onPrimary),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
