abstract class LocaleRepository {
  Future<String> getSavedLocale();
  Future<void> saveLocale(String locale);
}
