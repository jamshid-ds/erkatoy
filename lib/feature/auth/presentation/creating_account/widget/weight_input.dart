
import 'package:erkatoy_afex_ai/design_system/components/erkatoy_text_field.dart';
import 'package:flutter/material.dart';

class WeightInput extends StatelessWidget {
  const WeightInput({super.key, required this.weightKey, required this.controller});

  final GlobalKey<FormState> weightKey;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ErkatoyTextField(
        formKey: weightKey,
        hintText: 'Vazni',
        controller: controller,
        textInputType: const TextInputType.numberWithOptions(decimal: true),
        removeBorders: true,
      ),
    );
  }
}
