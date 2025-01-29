import 'package:baraka_portfolio/core/localization/app_localization.dart';
import 'package:baraka_portfolio/core/theme/app_theme.dart';
import 'package:baraka_portfolio/features/portfolio/presentation/screens/portfolio_screen.dart';
import 'package:baraka_portfolio/features/settings/presentation/logic/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            locale: Locale(state.locale),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const PortfolioScreen(),
          );
        },
      ),
    );
  }
}
