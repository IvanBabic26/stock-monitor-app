import 'package:baraka_portfolio/features/settings/presentation/logic/language_cubit.dart';
import 'package:baraka_portfolio/features/settings/presentation/widgets/language_selector_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<LanguageCubit>(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return LanguageSelectorDropDown(
            value: state.locale,
            onChange: (String newLocale) {
              context.read<LanguageCubit>().changeLanguage(newLocale);
            },
          );
        },
      ),
    );
  }
}
