import 'package:baraka_portfolio/features/portfolio/data/models/position_model.dart';
import 'package:baraka_portfolio/features/portfolio/presentation/widgets/stock_information_data.dart';
import 'package:baraka_portfolio/features/portfolio/presentation/widgets/stock_skeleton_loader.dart';
import 'package:flutter/material.dart';

class StockInformation extends StatelessWidget {
  final List<Position> positions;
  final bool isLoading;

  const StockInformation({
    super.key,
    required this.positions,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: isLoading
              ? List.generate(5, (i) => StockSkeletonLoader())
              : positions
                  .map(
                    (e) => StockInformationData(position: e),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
