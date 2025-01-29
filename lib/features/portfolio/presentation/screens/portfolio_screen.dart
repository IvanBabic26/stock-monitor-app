import 'package:baraka_portfolio/core/theme/app_colors.dart';
import 'package:baraka_portfolio/core/widgets/gradient_divider.dart';
import 'package:baraka_portfolio/features/portfolio/presentation/logic/portfolio_cubit.dart';
import 'package:baraka_portfolio/features/portfolio/presentation/widgets/stock_information.dart';
import 'package:baraka_portfolio/features/settings/presentation/widgets/settings_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PortfolioCubit()..fetchPortfolio(),
      child: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SettingsAppBar(
                    netValue: state.portfolioData?.balance?.netValue
                        ?.toStringAsFixed(2),
                    pnl: state.portfolioData?.balance?.pnl?.toStringAsFixed(2),
                    pnlPercentage: state.portfolioData?.balance?.pnlPercentage,
                    isLoading: state is PortfolioLoading,
                  ),
                  GradientDivider(
                    colors: AppColors.gradientHeaderDivider,
                  ),
                  StockInformation(
                    isLoading: state is PortfolioLoading,
                    positions: state.portfolio.portfolio?.positions ?? [],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
