import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/creating_account/bloc/create_account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderButton extends StatelessWidget {
  const GenderButton({super.key});

  final List<String> genderItems = const ['O`g`il', 'Qiz'];

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CreateAccountBloc, CreateAccountState, String?>(
      selector: (state) => state.gender,
      builder: (context, selectedItem) {
        return DropdownButtonHideUnderline(
          child: DropdownButton(
            value: selectedItem ?? genderItems.first,
            icon: const SizedBox(),
            borderRadius: getBorderAll16,
            items: genderItems
                .map((value) => DropdownMenuItem<String>(
                    value: value,
                    child: TextView(text: value, textColor: context.themeColors.onSurface)))
                .toList(),
            onChanged: (value) {
              context.read<CreateAccountBloc>().add(OnSelectGenderAuthEvent(value!));
            },
          ),
        );
      },
    );
  }
}
