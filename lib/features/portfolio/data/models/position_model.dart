import 'package:baraka_portfolio/features/portfolio/data/models/instrument_model.dart';

class Position {
  final Instrument? instrument;
  final double? quantity;
  final double? averagePrice;
  final double? cost;
  final double? marketValue;
  final double? pnl;
  final double? pnlPercentage;

  Position({
    this.instrument,
    this.quantity,
    this.averagePrice,
    this.cost,
    this.marketValue,
    this.pnl,
    this.pnlPercentage,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      instrument: json['instrument'] != null
          ? Instrument.fromJson(json['instrument'])
          : null,
      quantity: json['quantity']?.toDouble(),
      averagePrice: json['averagePrice']?.toDouble(),
      cost: json['cost']?.toDouble(),
      marketValue: json['marketValue']?.toDouble(),
      pnl: json['pnl']?.toDouble(),
      pnlPercentage: json['pnlPercentage']?.toDouble(),
    );
  }

  Position copyWith({
    Instrument? instrument,
    double? quantity,
    double? averagePrice,
    double? cost,
    double? marketValue,
    double? pnl,
    double? pnlPercentage,
  }) {
    return Position(
      instrument: instrument ?? this.instrument,
      quantity: quantity ?? this.quantity,
      averagePrice: averagePrice ?? this.averagePrice,
      cost: cost ?? this.cost,
      marketValue: marketValue ?? this.marketValue,
      pnl: pnl ?? this.pnl,
      pnlPercentage: pnlPercentage ?? this.pnlPercentage,
    );
  }
}