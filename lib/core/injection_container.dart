import 'package:baraka_portfolio/core/network/app_config.dart';
import 'package:baraka_portfolio/core/network/interceptors.dart';
import 'package:baraka_portfolio/core/network/repository.dart';
import 'package:baraka_portfolio/features/market_simulation/services/implementation/live_market_service.dart';
import 'package:baraka_portfolio/features/market_simulation/services/interfaces/market_service.dart';
import 'package:baraka_portfolio/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:baraka_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:baraka_portfolio/features/settings/data/datasources/locale_data_source.dart';
import 'package:baraka_portfolio/features/settings/data/repositories/locale_repository_impl.dart';
import 'package:baraka_portfolio/features/settings/domain/repositories/locale_repository.dart';
import 'package:baraka_portfolio/features/settings/domain/usecases/get_locale.dart';
import 'package:baraka_portfolio/features/settings/domain/usecases/set_locale.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerLazySingleton<AppConfig>(() => AppConfig());
  getIt.registerLazySingleton(() => AuthInterceptor());
  getIt.registerLazySingleton<Repository>(() => RepositoryImpl(
      baseUrl: getIt<AppConfig>().baseUrl,
      interceptor: getIt<AuthInterceptor>()));
  await _initServices();
  await _initRepositories();
  await _initUseCases();
}

Future<void> _initServices() async {
  getIt.registerLazySingleton<LocaleDataSource>(
    () => LocaleDataSource(),
  );
  getIt.registerLazySingleton<MarketService>(
    () => MarketServiceImpl(),
  );
}

Future<void> _initRepositories() async {
  getIt.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(baseRepository: getIt<Repository>()),
  );
  getIt.registerLazySingleton<LocaleRepository>(
    () => LocaleRepositoryImpl(getIt<LocaleDataSource>()),
  );
}

Future<void> _initUseCases() async {
  getIt.registerLazySingleton(() => GetLocale(getIt<LocaleRepository>()));
  getIt.registerLazySingleton(() => SetLocale(getIt<LocaleRepository>()));
}
