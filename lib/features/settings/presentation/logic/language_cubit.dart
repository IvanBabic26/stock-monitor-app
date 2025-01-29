import 'package:baraka_portfolio/core/injection_container.dart';
import 'package:baraka_portfolio/features/settings/domain/usecases/get_locale.dart';
import 'package:baraka_portfolio/features/settings/domain/usecases/set_locale.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final _getLocale = getIt<GetLocale>();
  final _setLocale = getIt<SetLocale>();

  LanguageCubit() : super(const LanguageState()) {
    _initializeLocale();
  }

  Future<void> _initializeLocale() async {
    final savedLocale = await _getLocale.call();
    emit(LanguageState(locale: savedLocale));
  }

  Future<void> changeLanguage(String newLocale) async {
    await _setLocale.call(newLocale);
    emit(LanguageState(locale: newLocale));
  }
}
