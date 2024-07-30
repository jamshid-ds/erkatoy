import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/design_system/components/erkatoy_text_field.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPasswordInput extends StatelessWidget {
  const RegisterPasswordInput({
    super.key,
    required this.formKey,
    required this.focusNode,
    required this.controller,
    required this.onKeyboardNextBtnPressed,
  });

  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;
  final TextEditingController controller;
  final VoidCallback onKeyboardNextBtnPressed;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, bool>(
      selector: (state) => state.obscureState,
      builder: (context, obscureState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextView(
              text: 'Parol',
              textSize: 12.textSize(context),
              textColor: context.themeColors.onSurface,
            ),
            getHeightSize4,
            ErkatoyTextField.passwordMode(
              formKey: formKey,
              hintText: 'Parolni kiriting',
              controller: controller,
              obscureText: obscureState,
              focusNode: focusNode,
              onEditingComplete: onKeyboardNextBtnPressed,
              onPressSuffixBtn: () {
                context.read<RegisterBloc>().add(OnObscurePressedRegisterEvent());
              },
              validator: (value) {
                if (value!.length < 8) return 'Parolning uzunligi 8 tadan kam bo`lmasligi kerak!';
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
