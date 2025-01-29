import 'package:baraka_portfolio/features/settings/data/datasources/locale_data_source.dart';
import 'package:baraka_portfolio/features/settings/domain/repositories/locale_repository.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  final LocaleDataSource localeDataSource;

  LocaleRepositoryImpl(this.localeDataSource);

  @override
  Future<String> getSavedLocale() async {
    return await localeDataSource.getLocale();
  }

  @override
  Future<void> saveLocale(String locale) async {
    await localeDataSource.setLocale(locale);
  }
}
