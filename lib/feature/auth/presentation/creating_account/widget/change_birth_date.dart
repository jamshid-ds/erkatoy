import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/design_system/components/birth_date_picker.dart';
import 'package:erkatoy_afex_ai/design_system/components/erkatoy_button.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/floating_ui.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/creating_account/bloc/create_account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeBirthDate extends StatelessWidget {
  const ChangeBirthDate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CreateAccountBloc, CreateAccountState, DateTime?>(
      selector: (state) => state.birthdayDate,
      builder: (context, changedDate) {
        return ErkatoyButton.outlined(
          onPressed: () {
            context.showModalPopUp(
              child: BirthDatePicker(
                initialDate: changedDate ?? DateTime.now(),
                onDateTimeChanged: (newDate) {
                  context.read<CreateAccountBloc>().add(OnChangeBirthDayDateAuthEvent(newDate));
                },
              ),
            );
          },
          buttonWidth: 1.screenWidth(context),
          buttonHeight: 48,
          text: changedDate == null ? 'Tug`ilgan sanasi' : dateTimeFormat(changedDate),
          textColor: context.themeColors.onSurface.withOpacity(changedDate == null ? 0.7 : 1.0),
          textSize: 16.textSize(context),
          removeSplash: true,
          textToLeft: true,
        );
      },
    );
  }
}
