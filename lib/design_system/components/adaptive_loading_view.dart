import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:flutter/material.dart';

final _myKey = GlobalKey();

class AdaptiveLoadingView extends StatelessWidget {
  const AdaptiveLoadingView({super.key});

  static void show(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      useSafeArea: true,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_) => AlertDialog.adaptive(
        shape: RoundedRectangleBorder(borderRadius: getBorderAll12),
        title: const AdaptiveLoadingView(),
      ),
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round),
    );
  }
}
