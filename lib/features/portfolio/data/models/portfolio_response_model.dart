import 'package:baraka_portfolio/features/portfolio/data/models/portfolio_model.dart';

class PortfolioResponse {
  final Portfolio? portfolio;

  PortfolioResponse({this.portfolio});

  factory PortfolioResponse.fromJson(Map<String, dynamic> json) {
    return PortfolioResponse(
      portfolio: json['portfolio'] != null
          ? Portfolio.fromJson(json['portfolio'])
          : null,
    );
  }

  PortfolioResponse copyWith({
    Portfolio? portfolio,
  }) {
    return PortfolioResponse(
      portfolio: portfolio ?? this.portfolio,
    );
  }
}
