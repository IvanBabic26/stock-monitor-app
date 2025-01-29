import 'dart:async';

import 'package:baraka_portfolio/core/injection_container.dart';
import 'package:baraka_portfolio/features/market_simulation/services/interfaces/market_service.dart';
import 'package:baraka_portfolio/features/portfolio/data/models/portfolio_model.dart';
import 'package:baraka_portfolio/features/portfolio/data/models/portfolio_response_model.dart';
import 'package:baraka_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final _portfolioRepository = getIt<PortfolioRepository>();
  final _marketService = getIt<MarketService>();
  StreamSubscription? _priceSubscription;

  PortfolioCubit() : super(PortfolioLoading(PortfolioResponse()));

  Future<void> fetchPortfolio() async {
    emit(PortfolioLoading(PortfolioResponse()));
    try {
      final portfolio = await _portfolioRepository.getPortfolio();
      emit(PortfolioState(portfolio));
      _startPriceSimulation(portfolio);
    } catch (e) {
      emit(PortfolioError(state.portfolio, e.toString()));
    }
  }

  void _startPriceSimulation(PortfolioResponse portfolio) {
    /// this extracts the initial prices from portfolio from the API response
    /// we check if it is empty or not and make a MapEntry
    final initialPrices = Map<String, double>.fromEntries(
      portfolio.portfolio?.positions
              ?.where((position) =>
                  position.instrument?.ticker != null &&
                  position.instrument?.lastTradedPrice != null)
              .map(
                (position) => MapEntry(
                  position.instrument!.ticker!,
                  position.instrument!.lastTradedPrice!,
                ),
              ) ??
          [],
    );

    if (initialPrices.isEmpty) {
      emit(PortfolioError(state.portfolio, "No valid prices to simulate"));
      return;
    }

    _marketService.startSimulation(initialPrices);

    _priceSubscription?.cancel();
    _priceSubscription = _marketService.getPriceUpdates().listen(
      (newPrices) {
        _updatePortfolioPrices(newPrices);
      },
      onError: (error) {
        emit(PortfolioError(state.portfolio, error.toString()));
      },
    );
  }

  void _updatePortfolioPrices(Map<String, double> newPrices) {
    final currentPortfolio = state.portfolio.portfolio;

    final updatedPositions = currentPortfolio?.positions?.map((position) {
      final newPrice = newPrices[position.instrument?.ticker];
      if (newPrice == null) return position;

      final updatedInstrument = position.instrument?.copyWith(
        lastTradedPrice: newPrice,
      );

      /// this recalculates the position values
      final marketValue = (position.quantity ?? 0) * newPrice;
      final pnl = marketValue - (position.cost ?? 0);
      final pnlPercentage =
          position.cost != 0 ? (pnl * 100) / position.cost! : 0;

      return position.copyWith(
        instrument: updatedInstrument,
        marketValue: marketValue,
        pnl: pnl,
        pnlPercentage: pnlPercentage.toDouble(),
      );
    }).toList();

    /// this recalculate portfolio balance
    final netValue = updatedPositions?.fold(
      0.0,
      (sum, position) => sum + (position.marketValue ?? 0),
    );
    final totalPnl = updatedPositions?.fold(
      0.0,
      (sum, position) => sum + (position.pnl ?? 0),
    );
    final totalCost = updatedPositions?.fold(
      0.0,
      (sum, position) => sum + (position.cost ?? 0),
    );
    final pnlPercentage = ((totalPnl ?? 0) * 100) / (totalCost ?? 0);

    final updatedBalance = currentPortfolio?.balance?.copyWith(
      netValue: netValue,
      pnl: totalPnl,
      pnlPercentage: pnlPercentage,
    );

    final updatedPortfolio = currentPortfolio?.copyWith(
      balance: updatedBalance,
      positions: updatedPositions,
    );

    emit(PortfolioState(PortfolioResponse(portfolio: updatedPortfolio)));
  }

  @override
  Future<void> close() async {
    _priceSubscription?.cancel();
    _marketService.dispose();
    super.close();
  }
}
