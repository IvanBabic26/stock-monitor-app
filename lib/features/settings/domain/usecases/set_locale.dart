import 'package:baraka_portfolio/features/settings/domain/repositories/locale_repository.dart';

class SetLocale {
  final LocaleRepository repository;

  SetLocale(this.repository);

  Future<void> call(String locale) async {
    await repository.saveLocale(locale);
  }
}
