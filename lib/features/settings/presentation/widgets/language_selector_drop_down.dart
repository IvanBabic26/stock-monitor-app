import 'package:baraka_portfolio/core/localization/app_localization.dart';
import 'package:flutter/material.dart';

class LanguageSelectorDropDown extends StatelessWidget {
  const LanguageSelectorDropDown({
    super.key,
    required this.value,
    required this.onChange,
  });

  final String value;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      items: AppLocalizations.supportedLocales.map((e) => e.languageCode).map(
        (lang) {
          return DropdownMenuItem(
            value: lang,
            child: Text(lang.toUpperCase()),
          );
        },
      ).toList(),
      onChanged: (newLang) {
        if (newLang != null) {
          onChange(newLang);
        }
      },
    );
  }
}
