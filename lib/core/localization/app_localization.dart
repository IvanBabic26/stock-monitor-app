import 'package:baraka_portfolio/core/localization/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  static List<Locale> supportedLocales = S.delegate.supportedLocales;

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
