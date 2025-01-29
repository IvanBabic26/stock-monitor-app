import 'package:baraka_portfolio/features/settings/domain/repositories/locale_repository.dart';

class GetLocale {
  final LocaleRepository repository;

  GetLocale(this.repository);

  Future<String> call() async {
    return await repository.getSavedLocale();
  }
}
