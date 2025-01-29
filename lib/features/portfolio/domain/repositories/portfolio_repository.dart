import 'package:baraka_portfolio/features/portfolio/data/models/portfolio_response_model.dart';

abstract class PortfolioRepository {
  Future<PortfolioResponse> getPortfolio();
}