import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/design_system/components/adaptive_loading_view.dart';
import 'package:erkatoy_afex_ai/design_system/components/no_connection_dialog.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension FloatingUi on BuildContext {
  void showModalPopUp({required Widget child}) {
    showCupertinoModalPopup<void>(
      context: this,
      builder: (context) => Container(
        height: 0.6.screenWidth(this),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Theme.of(context).colorScheme.surface.withOpacity(0.99),
        child: SafeArea(top: false, child: SafeArea(top: false, child: child)),
      ),
    );
  }

  void showOnErrorSnackBar(
    String message, {
    bool isActionBarAvailable = false,
    bool onError = true,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: TextView(
            text: message,
            textColor: onError ? themeColors.onError : themeColors.onPrimary,
          ),
          backgroundColor:
              onError ? themeColors.error.withOpacity(0.9) : themeColors.primary.withOpacity(0.9),
          shape: RoundedRectangleBorder(borderRadius: getBorderAll12),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 0.9.screenHeight(this) - (isActionBarAvailable ? kToolbarHeight : 10),
          ),
        ),
      );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: TextView(text: message, textColor: themeColors.surface),
          shape: RoundedRectangleBorder(borderRadius: getBorderAll12),
          padding: getPaddingAll8,
        ),
      );
  }

  Future<void> showConnectivityDialog() async {
    await showAdaptiveDialog(
      context: this,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (_) => NoConnectionDialog(key: noConnectionDialogKey),
    );
  }

  Future<void> showLoadingDialog() async {
    await showAdaptiveDialog(
      barrierDismissible: true,
      useSafeArea: true,
      context: this,
      builder: (_) => AlertDialog.adaptive(
        shape: RoundedRectangleBorder(borderRadius: getBorderAll12),
        title: const AdaptiveLoadingView(),
      ),
    );
  }
}

// BirthDatePicker(
//               initialDate: _changedDate,
//               onDateTimeChanged: (newDate) {
//                 setState(() {
//                   _changedDate = newDate;
//                 });
//               })),
