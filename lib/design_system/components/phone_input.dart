import 'package:erkatoy_afex_ai/core/base/base_extensions.dart';
import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/design_system/components/erkatoy_text_field.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextView(
          text: 'Telefon raqamingizni kiriting',
          textSize: 12.textSize(context),
          textColor: context.themeColors.onSurface,
        ),
        getHeightSize4,
        ErkatoyTextField(
          formKey: formKey,
          hintText: '+9989',
          controller: controller,
          focusNode: focusNode,
          textInputType: TextInputType.phone,
          maxLength: 13,
          validator: (value) {
            if (!value!.phoneNumbIsValid) return 'Format noto`g`ri!';
            return null;
          },
        ),
      ],
    );
  }
}
