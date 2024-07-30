import 'package:erkatoy_afex_ai/design_system/components/erkatoy_text_field.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReEnterPasswordInput extends StatelessWidget {
  const ReEnterPasswordInput({
    super.key,
    required this.formKey,
    required this.focusNode,
    required this.controller,
    required this.firstPasswordText,
  });

  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;
  final TextEditingController controller;
  final String firstPasswordText;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, bool>(
      selector: (state) => state.reObscureState,
      builder: (context, obscureState) {
        return ErkatoyTextField.passwordMode(
          formKey: formKey,
          hintText: 'Parolni qayta kiriting',
          controller: controller,
          obscureText: obscureState,
          focusNode: focusNode,
          inputActionIsNext: false,
          onPressSuffixBtn: () {
            context.read<RegisterBloc>().add(OnReObscurePressedRegisterEvent());
          },
          validator: (value) {
            if (value!.length < 8) return 'Parolning uzunligi 8 tadan kam bo`lmasligi kerak!';
            if (value != firstPasswordText) return 'Qayta kiritilgan parol noto`g`ri';
            return null;
          },
        );
      },
    );
  }
}
