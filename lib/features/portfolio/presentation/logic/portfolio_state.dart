part of 'portfolio_cubit.dart';

class PortfolioState extends Equatable {
  const PortfolioState(this.portfolio);

  final PortfolioResponse portfolio;

  Portfolio? get portfolioData => portfolio.portfolio;

  @override
  List<Object> get props => [portfolio, identityHashCode(this)];
}

class PortfolioLoading extends PortfolioState {
  const PortfolioLoading(super.portfolio);

  @override
  List<Object> get props => [];
}

class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError(super.portfolio, this.message);

  @override
  List<Object> get props => [message];
}
