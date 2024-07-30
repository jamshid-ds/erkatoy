import 'package:erkatoy_afex_ai/design_system/components/erkatoy_button.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/creating_account/bloc/create_account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountBloc, CreateAccountState>(
      builder: (context, state) {
        final bool buttonState =
            state.weight.isNotEmpty && (state.gender != null) && (state.birthdayDate != null);
        return ErkatoyButton(
          onPressed: buttonState ? () {} : null,
          text: 'Boshlash',
          buttonHeight: 48,
          textColor: context.themeColors.onPrimary,
          buttonColor: context.themeColors.primary,
          textSize: 16.textSize(context),
        );
      },
    );
  }
}
