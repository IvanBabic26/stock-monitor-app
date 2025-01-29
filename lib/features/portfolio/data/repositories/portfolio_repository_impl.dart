import 'package:baraka_portfolio/core/network/repository.dart';
import 'package:baraka_portfolio/features/portfolio/data/models/portfolio_response_model.dart';
import 'package:baraka_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final Repository baseRepository;

  PortfolioRepositoryImpl({required this.baseRepository});

  @override
  Future<PortfolioResponse> getPortfolio() async {
    final dio = await baseRepository.getRepository();
    final response = await dio.get('');
    return PortfolioResponse.fromJson(response.data);
  }
}
