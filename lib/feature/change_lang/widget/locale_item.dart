import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:erkatoy_afex_ai/feature/change_lang/bloc/change_lang_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocaleItem extends StatelessWidget {
  const LocaleItem({
    super.key,
    required this.iconsAsset,
    required this.localeName,
  });

  final String iconsAsset;
  final String localeName;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChangeLangBloc, ChangeLangState, String?>(
      selector: (state) => state.changedLocale,
      builder: (context, changedLocale) {
        return ListTile(
          onTap: () {
            context.read<ChangeLangBloc>().add(OnChangeLocaleEvent(localeName));
          },
          leading: SvgPicture.asset(iconsAsset, fit: BoxFit.cover),
          title: TextView(
            text: localeName,
            textSize: 16.textSize(context),
            textColor: changedLocale == localeName
                ? context.themeColors.onPrimary
                : context.themeColors.onSurface,
          ),
          trailing: changedLocale == localeName
              ? Icon(Icons.done_rounded, color: context.themeColors.onPrimary)
              : null,
          tileColor: changedLocale == localeName
              ? context.themeColors.primary
              : context.themeColors.surface,
          splashColor: context.themeColors.primary,
          shape: RoundedRectangleBorder(borderRadius: getBorderAll10),
        );
      },
    );
  }

// Locale _getLocaleByText() {
// debugPrint('lang: $languageText');
// if (languageText == "uzbek_lang_name") {
//   return AppLocalization.uzLocale;
// } else if (languageText == "russian_lang_name") {
//   return AppLocalization.ruLocale;
// } else if (languageText == "english_lang_name") {
//   return AppLocalization.enLocale;
// }
// return AppLocalization.uzLocale;
// }
}
