import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/design_system/components/erkatoy_text_field.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPasswordInput extends StatelessWidget {
  const LoginPasswordInput({
    super.key,
    required this.formKey,
    required this.focusNode,
    required this.controller,
  });

  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, bool>(
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
              inputActionIsNext: false,
              onPressSuffixBtn: () {
                context.read<LoginBloc>().add(OnObscurePressedLoginEvent());
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
