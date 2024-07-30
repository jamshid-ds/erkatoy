import 'package:flutter/material.dart';

class AppLocalizations {
  // static Future<AppLocalizations> load(Locale locale) {
  //   final String name = locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
  //   final String localeName = Intl.canonicalizedLocale(name);
  //
  //   return initializeMessages(localeName).then((_) {
  //     Intl.defaultLocale = localeName;
  //     return AppLocalizations();
  //   });
  // }

  // static AppLocalizations? of(BuildContext context) {
  //   return Localizations.of<AppLocalizations>(context, AppLocalizations);
  // }

  ///supported locales
  static const Locale uzLocale = Locale('uz', 'UZ');
  static const Locale enLocale = Locale('en', 'US');
  static const Locale ruLocale = Locale('ru', 'RU');

  static const List<Locale> supportedLocales = [uzLocale, enLocale, ruLocale];
}
