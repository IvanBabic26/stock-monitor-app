import 'package:baraka_portfolio/core/injection_container.dart';
import 'package:baraka_portfolio/core/localization/l10n.dart';
import 'package:baraka_portfolio/core/widgets/gradient_divider.dart';
import 'package:baraka_portfolio/features/market_simulation/services/interfaces/market_service.dart';
import 'package:baraka_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:baraka_portfolio/features/portfolio/presentation/logic/portfolio_cubit.dart';
import 'package:baraka_portfolio/features/portfolio/presentation/screens/portfolio_screen.dart';
import 'package:baraka_portfolio/features/portfolio/presentation/widgets/stock_information.dart';
import 'package:baraka_portfolio/features/settings/domain/repositories/locale_repository.dart';
import 'package:baraka_portfolio/features/settings/domain/usecases/get_locale.dart';
import 'package:baraka_portfolio/features/settings/domain/usecases/set_locale.dart';
import 'package:baraka_portfolio/features/settings/presentation/logic/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';

class MockPortfolioRepository extends Mock implements PortfolioRepository {}

class MockLocaleRepository extends Mock implements LocaleRepository {}

class MockPortfolioService extends Mock implements MarketService {}

void main() {
  late MockPortfolioRepository mockPortfolioRepository;
  late MockLocaleRepository mockLocaleRepository;
  late MockPortfolioService mockPortfolioService;

  setUp(() {
    getIt.reset();
    mockPortfolioRepository = MockPortfolioRepository();
    mockLocaleRepository = MockLocaleRepository();

    mockPortfolioService = MockPortfolioService();

    getIt.registerLazySingleton<MarketService>(() => mockPortfolioService);
    getIt.registerLazySingleton<PortfolioRepository>(
        () => mockPortfolioRepository);
    getIt.registerLazySingleton<LocaleRepository>(() => mockLocaleRepository);
    when(() => mockLocaleRepository.getSavedLocale())
        .thenAnswer((_) async => 'en');

    getIt.registerLazySingleton<GetLocale>(
        () => GetLocale(mockLocaleRepository));
    getIt.registerLazySingleton<SetLocale>(
        () => SetLocale(mockLocaleRepository));
    getIt.registerFactory(() => LanguageCubit());
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('PortfolioScreen renders correctly with mocked data',
      (tester) async {
    when(() => mockPortfolioRepository.getPortfolio()).thenAnswer(
      (_) async => mockPortfolioResponseModel,
    );

    final portfolioCubit = PortfolioCubit();

    await tester.pumpWidget(
      wrapWithLocalization(
        BlocProvider.value(
          value: portfolioCubit,
          child: const PortfolioScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(
        find.text(mockPortfolioResponseModel.portfolio?.balance?.netValue
                ?.toStringAsFixed(2) ??
            ''),
        findsOneWidget);

    final richTextFinder = find.byWidgetPredicate(
      (widget) {
        if (widget is! RichText) return false;

        final spans = (widget.text as TextSpan).children;
        if (spans == null) return false;

        return spans.any((span) =>
                span is TextSpan &&
                span.text ==
                    mockPortfolioResponseModel.portfolio?.balance?.pnl
                        ?.toStringAsFixed(2)) &&
            spans.any((span) => span is TextSpan && span.text == " (") &&
            spans.any((span) =>
                span is TextSpan &&
                span.text ==
                    "${mockPortfolioResponseModel.portfolio?.balance?.pnlPercentage?.toStringAsFixed(2)}%") &&
            spans.any((span) => span is TextSpan && span.text == ")");
      },
    );

    expect(richTextFinder, findsOneWidget);
  });

  group('StockInformation', () {
    testWidgets('renders positions correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWithLocalization(
          Column(
            children: [
              StockInformation(
                positions:
                    mockPortfolioResponseModel.portfolio?.positions ?? [],
              ),
            ],
          ),
        ),
      );

      final richTextFinder = find.byWidgetPredicate(
        (widget) {
          if (widget is! RichText) return false;

          final spans = (widget.text as TextSpan).children;
          if (spans == null) return false;

          return spans.any((span) =>
                  span is TextSpan &&
                  span.text ==
                      mockPortfolioResponseModel.portfolio?.positions?.first.pnl
                          ?.toStringAsFixed(2)) &&
              spans.any((span) => span is TextSpan && span.text == " (") &&
              spans.any((span) =>
                  span is TextSpan &&
                  span.text ==
                      "${mockPortfolioResponseModel.portfolio?.positions?.first.pnlPercentage?.toStringAsFixed(2)}%") &&
              spans.any((span) => span is TextSpan && span.text == ")");
        },
      );

      expect(richTextFinder, findsOneWidget);
    });
  });
  group('GradientDivider', () {
    testWidgets('renders with correct colors', (WidgetTester tester) async {
      final testColors = [Colors.red, Colors.blue];

      await tester.pumpWidget(
        wrapWithLocalization(GradientDivider(colors: testColors)),
      );

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final container = tester.widget<Container>(containerFinder);
      expect(container.decoration, isNotNull);
      expect(container.decoration, isInstanceOf<BoxDecoration>());
    });
  });
}

Widget wrapWithLocalization(Widget child) {
  return BlocProvider(
    create: (_) => LanguageCubit(),
    child: MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: child,
    ),
  );
}
