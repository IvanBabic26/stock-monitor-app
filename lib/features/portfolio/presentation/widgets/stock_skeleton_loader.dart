import 'package:baraka_portfolio/core/theme/app_colors.dart';
import 'package:baraka_portfolio/core/theme/app_text_style.dart';
import 'package:baraka_portfolio/core/widgets/gradient_divider.dart';
import 'package:baraka_portfolio/core/widgets/skeleton_item.dart';
import 'package:flutter/material.dart';

class StockSkeletonLoader extends StatelessWidget {
  const StockSkeletonLoader({super.key});

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
                  SkeletonItem(width: 86, height: 14),
                  Row(
                    children: [
                      SkeletonItem(),
                      Text(
                        " (", // Open bracket
                        style: AppTextStyles.headline1,
                      ),
                      SkeletonItem(width: 32),
                      Text(
                        ")", // Close bracket
                        style: AppTextStyles.headline1,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SkeletonItem(width: 36),
                        const SizedBox(width: 4),
                        SkeletonItem(),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SkeletonItem(width: 24),
                      const SizedBox(width: 4),
                      Text('x'),
                      const SizedBox(width: 4),
                      SkeletonItem(width: 36),
                      Text('='),
                      const SizedBox(width: 4),
                      SkeletonItem(),
                    ],
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
                      SkeletonItem(width: 60),
                      const SizedBox(height: 4),
                      SkeletonItem(),
                    ],
                  ),
                  Flexible(
                    child: SkeletonItem(),
                  ),
                ],
              ),
            ],
          ),
        ),
        GradientDivider(colors: AppColors.gradientDivider)
      ],
    );
  }
}
