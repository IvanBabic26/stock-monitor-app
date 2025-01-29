part of 'language_cubit.dart';

class LanguageState extends Equatable {
  final String locale;

  const LanguageState({this.locale = 'en'});

  @override
  List<Object> get props => [locale];
}
