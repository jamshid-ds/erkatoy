import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';

import 'google_font_style.dart';

class ErkatoyTextField extends StatelessWidget {
  const ErkatoyTextField({
    super.key,
    required this.formKey,
    required this.hintText,
    required this.controller,
    this.focusNode,
    required this.textInputType,
    this.validator,
    this.isExpand = false,
    this.removeBorders = false,
    this.inputActionIsNext = true,
    this.onEditingComplete,
    this.maxLength,
  })  : isReadOnly = false,
        obscureText = false,
        onPressSuffixBtn = null,
        onTap = null;

  const ErkatoyTextField.readOnlyMode({
    super.key,
    required this.formKey,
    required this.hintText,
    this.focusNode,
    this.validator,
    required this.controller,
    this.inputActionIsNext = true,
    this.onEditingComplete,
    this.onTap,
    this.maxLength,
  })  : isReadOnly = true,
        obscureText = false,
        textInputType = TextInputType.none,
        isExpand = false,
        removeBorders = true,
        onPressSuffixBtn = null;

  const ErkatoyTextField.passwordMode({
    super.key,
    required this.formKey,
    required this.hintText,
    this.focusNode,
    this.validator,
    this.onPressSuffixBtn,
    required this.controller,
    required this.obscureText,
    this.inputActionIsNext = true,
    this.onEditingComplete,
    this.onTap,
    this.maxLength,
  })  : isReadOnly = false,
        textInputType = TextInputType.visiblePassword,
        isExpand = false,
        removeBorders = false;

  final GlobalKey<FormState> formKey;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final bool obscureText;
  final bool isReadOnly;
  final bool isExpand;
  final VoidCallback? onTap;
  final VoidCallback? onPressSuffixBtn;
  final VoidCallback? onEditingComplete;
  final bool removeBorders;
  final bool inputActionIsNext;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Theme.of(context).colorScheme.primary,
        textInputAction: inputActionIsNext ? TextInputAction.next : TextInputAction.done,
        maxLength: maxLength,
        keyboardType: textInputType,
        cursorOpacityAnimates: true,
        obscureText: obscureText,
        expands: isExpand,
        readOnly: isReadOnly,
        onEditingComplete: onEditingComplete,
        cursorErrorColor: Theme.of(context).colorScheme.error,
        onTap: onTap,
        textCapitalization: (textInputType == TextInputType.name)
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        validator: (value) {
          if (value == null || value.isEmpty) return 'maydon bo`sh bo`lmasligi kerak!';
          return validator?.call(value);
        },
        style: googleFontStyle(
          fontSize: 16.textSize(context),
          fontColor: Theme.of(context).colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          enabled: true,
          filled: true,
          isDense: true,
          counterText: '',
          fillColor: context.themeColors.surface,
          hintText: hintText,
          hintStyle: googleFontStyle(fontSize: 16.textSize(context)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: getBorderAll10,
          ),
          suffixIcon: textInputType == TextInputType.visiblePassword
              ? IconButton(
                  onPressed: onPressSuffixBtn,
                  icon: Icon(
                    !obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : null,
          errorBorder: OutlineInputBorder(
            borderRadius: getBorderAll8,
            borderSide: adaptiveBorderSide(
              context,
              color: context.themeColors.error,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: getBorderAll8,
            borderSide: adaptiveBorderSide(
              context,
              color: context.themeColors.primary,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: getBorderAll8,
            borderSide: adaptiveBorderSide(
              context,
              color: context.themeColors.error,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  BorderSide adaptiveBorderSide(BuildContext context, {required Color color, double? width}) {
    return removeBorders
        ? const BorderSide(color: Colors.grey)
        : BorderSide(color: color, width: width ?? 1.0);
  }
}
