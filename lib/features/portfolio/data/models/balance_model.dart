class Balance {
  final double? netValue;
  final double? pnl;
  final double? pnlPercentage;

  Balance({
    this.netValue,
    this.pnl,
    this.pnlPercentage,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      netValue: json['netValue']?.toDouble(),
      pnl: json['pnl']?.toDouble(),
      pnlPercentage: json['pnlPercentage']?.toDouble(),
    );
  }

  Balance copyWith({
    double? netValue,
    double? pnl,
    double? pnlPercentage,
  }) {
    return Balance(
      netValue: netValue ?? this.netValue,
      pnl: pnl ?? this.pnl,
      pnlPercentage: pnlPercentage ?? this.pnlPercentage,
    );
  }
}
