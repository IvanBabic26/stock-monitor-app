import 'package:baraka_portfolio/core/theme/app_colors.dart';
import 'package:baraka_portfolio/core/theme/app_text_style.dart';
import 'package:baraka_portfolio/core/widgets/gradient_divider.dart';
import 'package:baraka_portfolio/features/portfolio/data/models/position_model.dart';
import 'package:flutter/material.dart';

class StockInformationData extends StatelessWidget {
  const StockInformationData({super.key, required this.position});

  final Position position;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(36, 16.0, 24.0, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    position.instrument?.ticker ?? '',
                    style: AppTextStyles.headline1,
                  ),
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.headline2,
                      children: [
                        TextSpan(
                          text: position.pnl?.toStringAsFixed(2),
                        ),
                        TextSpan(
                          text: " (", // Open bracket
                        ),
                        TextSpan(
                          text:
                              '${position.pnlPercentage?.toStringAsFixed(2)}%',
                          style: AppTextStyles.headline2.copyWith(
                            color: position.pnlPercentage != null &&
                                    position.pnlPercentage!.isNegative
                                ? AppColors.red
                                : AppColors.green,
                          ),
                        ),
                        TextSpan(
                          text: ")", // Close bracket
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${position.instrument?.currency} ',
                          style: AppTextStyles.headline2.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: position.instrument?.lastTradedPrice
                              ?.toStringAsFixed(2),
                          style: AppTextStyles.headline2,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '${position.quantity} x ${position.averagePrice} = ${calculateTotal(quantity: position.quantity!, averagePrice: position.averagePrice!).toStringAsFixed(2)}',
                      style: AppTextStyles.label2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(position.instrument?.name ?? ''),
                      const SizedBox(height: 4),
                      Text(position.instrument?.exchange ?? ''),
                    ],
                  ),
                  Flexible(
                    child: Text(position.marketValue?.toStringAsFixed(2) ?? ''),
                  ),
                ],
              ),
            ],
          ),
        ),
        GradientDivider(colors: [Colors.grey.shade400, Colors.grey.shade400])
      ],
    );
  }

  calculateTotal({required double quantity, required double averagePrice}) {
    return quantity * averagePrice;
  }
}
