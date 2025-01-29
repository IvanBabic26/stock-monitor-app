class Instrument {
  final String? ticker;
  final String? name;
  final String? exchange;
  final String? currency;
  final double? lastTradedPrice;

  Instrument({
    this.ticker,
    this.name,
    this.exchange,
    this.currency,
    this.lastTradedPrice,
  });

  factory Instrument.fromJson(Map<String, dynamic> json) {
    return Instrument(
      ticker: json['ticker'],
      name: json['name'],
      exchange: json['exchange'],
      currency: json['currency'],
      lastTradedPrice: json['lastTradedPrice']?.toDouble(),
    );
  }

  Instrument copyWith({
    String? ticker,
    String? name,
    String? exchange,
    String? currency,
    double? lastTradedPrice,
  }) {
    return Instrument(
      ticker: ticker ?? this.ticker,
      name: name ?? this.name,
      exchange: exchange ?? this.exchange,
      currency: currency ?? this.currency,
      lastTradedPrice: lastTradedPrice ?? this.lastTradedPrice,
    );
  }
}