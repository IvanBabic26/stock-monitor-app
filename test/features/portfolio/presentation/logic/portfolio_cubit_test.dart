import 'package:baraka_portfolio/core/injection_container.dart';
import 'package:baraka_portfolio/features/market_simulation/services/interfaces/market_service.dart';
import 'package:baraka_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:baraka_portfolio/features/portfolio/presentation/logic/portfolio_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../constants.dart';

class MockPortfolioCubit extends MockCubit<PortfolioState>
    implements PortfolioCubit {}

class MockPortfolioRepository extends Mock implements PortfolioRepository {}

class MockPortfolioService extends Mock implements MarketService {}

void main() {
  late PortfolioCubit mockPortfolioCubit;
  late MockPortfolioRepository mockPortfolioRepository;
  late MockPortfolioService mockPortfolioService;

  setUp(
    () async {
      getIt.reset();
      await initDependencies();
      getIt.unregister<PortfolioRepository>();
      getIt.unregister<MarketService>();
      mockPortfolioRepository = MockPortfolioRepository();

      getIt.registerLazySingleton<PortfolioRepository>(
          () => mockPortfolioRepository);

      mockPortfolioService = MockPortfolioService();

      getIt.registerLazySingleton<MarketService>(() => mockPortfolioService);
      mockPortfolioCubit = PortfolioCubit();
      when(() => mockPortfolioService.getPriceUpdates()).thenAnswer(
        (_) => Stream.value(<String, double>{
          'AAPL': 150.0,
          'GOOGL': 2800.0,
        }).asBroadcastStream(),
      );
    },
  );

  tearDown(() {
    mockPortfolioCubit.close();
    getIt.reset();
  });

  blocTest<PortfolioCubit, PortfolioState>(
    'emits [PortfolioLoading, PortfolioState] with correct data when getPortfolio succeeds',
    build: () {
      when(() => mockPortfolioRepository.getPortfolio())
          .thenAnswer((_) async => mockPortfolioResponseModel);
      return mockPortfolioCubit;
    },
    act: (cubit) => cubit.fetchPortfolio(),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      isA<PortfolioLoading>(),
      isA<PortfolioState>().having(
        (state) => state.portfolio,
        'portfolio',
        mockPortfolioResponseModel,
      ),
      isA<PortfolioState>(),
    ],
    verify: (_) {
      verify(() => mockPortfolioRepository.getPortfolio()).called(1);
      verify(() => mockPortfolioService.getPriceUpdates()).called(1);
    },
  );

  blocTest<PortfolioCubit, PortfolioState>(
    'emits [PortfolioLoading, PortfolioError] when getPortfolio fails',
    build: () {
      when(() => mockPortfolioRepository.getPortfolio())
          .thenThrow(Exception('Failed to fetch data'));
      return mockPortfolioCubit;
    },
    act: (cubit) => cubit.fetchPortfolio(),
    expect: () => [
      isA<PortfolioLoading>(),
      isA<PortfolioError>().having(
        (state) => state.message,
        'message',
        'Exception: Failed to fetch data',
      ),
    ],
    verify: (_) {
      verify(() => mockPortfolioRepository.getPortfolio()).called(1);
    },
  );

  test('initial state is PortfolioLoading', () {
    expect(mockPortfolioCubit.state, isA<PortfolioLoading>());
  });
}
