import 'dart:async';
import 'dart:math';

import 'package:baraka_portfolio/features/market_simulation/services/interfaces/market_service.dart';

class MarketServiceImpl implements MarketService {
  final _random = Random();
  Timer? _timer;
  final _priceController = StreamController<Map<String, double>>.broadcast();

  @override
  Stream<Map<String, double>> getPriceUpdates() => _priceController.stream;

  @override
  void startSimulation(Map<String, double> initialPrices) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final newPrices = <String, double>{};

      initialPrices.forEach((symbol, basePrice) {
        final variation = (_random.nextDouble() - 0.5) * 0.2; // -10% to +10%
        final newPrice = basePrice * (1 + variation);
        newPrices[symbol] = double.parse(newPrice.toStringAsFixed(2));
      });

      if (!_priceController.isClosed) {
        _priceController.add(newPrices);
      }
    });
  }

  @override
  void stopSimulation() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    stopSimulation();
    _priceController.close();
  }
}
