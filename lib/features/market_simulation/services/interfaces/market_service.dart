abstract class MarketService {
  Stream<Map<String, double>> getPriceUpdates();
  void startSimulation(Map<String, double> initialPrices);
  void stopSimulation();
  void dispose();
}
