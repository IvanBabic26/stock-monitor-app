import 'package:baraka_portfolio/features/portfolio/data/models/balance_model.dart';
import 'package:baraka_portfolio/features/portfolio/data/models/position_model.dart';

class Portfolio {
  final Balance? balance;
  final List<Position>? positions;

  Portfolio({this.balance, this.positions});

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      balance:
          json['balance'] != null ? Balance.fromJson(json['balance']) : null,
      positions: json['positions'] != null
          ? (json['positions'] as List)
              .map((position) => Position.fromJson(position))
              .toList()
          : null,
    );
  }

  Portfolio copyWith({
    Balance? balance,
    List<Position>? positions,
  }) {
    return Portfolio(
      balance: balance ?? this.balance,
      positions: positions ?? this.positions,
    );
  }
}
