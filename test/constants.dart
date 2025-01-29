import 'package:baraka_portfolio/features/portfolio/data/models/portfolio_response_model.dart';

final mockPortfolioResponse = {
  "portfolio": {
    "balance": {"netValue": 150000.50, "pnl": 5000.25, "pnlPercentage": 3.45},
    "positions": [
      {
        "instrument": {
          "ticker": "AAPL",
          "name": "Apple Inc.",
          "exchange": "NASDAQ",
          "currency": "USD",
          "lastTradedPrice": 150.25
        },
        "quantity": 100,
        "averagePrice": 145.00,
        "cost": 14500.00,
        "marketValue": 15025.00,
        "pnl": 525.00,
        "pnlPercentage": 3.62
      },
      {
        "instrument": {
          "ticker": "TSLA",
          "name": "Tesla Inc.",
          "exchange": "NASDAQ",
          "currency": "USD",
          "lastTradedPrice": 700.00
        },
        "quantity": 50,
        "averagePrice": 680.00,
        "cost": 34000.00,
        "marketValue": 35000.00,
        "pnl": 1000.00,
        "pnlPercentage": 2.94
      }
    ]
  }
};

final mockPortfolioResponseModel =
    PortfolioResponse.fromJson(mockPortfolioResponse);
