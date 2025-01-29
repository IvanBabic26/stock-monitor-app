import 'package:shared_preferences/shared_preferences.dart';

class LocaleDataSource {
  static const String _localeKey = 'selected_locale';

  Future<String> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey) ?? 'en';
  }

  Future<void> setLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale);
  }
}
