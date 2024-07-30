import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';

import 'text_view.dart';

class OnErrorWidget extends StatelessWidget {
  const OnErrorWidget({super.key, required this.errorText, this.onClick});

  final String errorText;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: onClick,
          child: TextView(
            text: errorText,
            maxLines: 5,
            textColor: Theme.of(context).colorScheme.error,
            textOverflow: TextOverflow.ellipsis,
            textSize: 20.textSize(context),
          ),
        ),
      ),
    );
  }
}
