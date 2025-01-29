import 'package:baraka_portfolio/core/constants/app_strings.dart';
import 'package:baraka_portfolio/core/localization/l10n.dart';
import 'package:baraka_portfolio/core/theme/app_colors.dart';
import 'package:baraka_portfolio/core/theme/app_text_style.dart';
import 'package:baraka_portfolio/core/widgets/skeleton_item.dart';
import 'package:baraka_portfolio/features/settings/presentation/widgets/language_selector.dart';
import 'package:flutter/material.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({
    super.key,
    this.netValue,
    this.pnl,
    this.pnlPercentage,
    this.isLoading = false,
  });

  final String? netValue;
  final String? pnl;
  final double? pnlPercentage;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        36.0,
        MediaQuery.of(context).padding.top,
        24,
        24,
      ),
      decoration: BoxDecoration(color: Color(0xFFE6FBFD)),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(),
              const SizedBox(width: 16),
              Text(johnDoe),
              Spacer(),
              LanguageSelector(),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLoading
                      ? SkeletonItem()
                      : Text(netValue ?? '', style: AppTextStyles.headline1),
                  const SizedBox(height: 8),
                  Text(S.current.netValue)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                        )
                      : RichText(
                          text: TextSpan(
                            style: AppTextStyles.headline1,
                            children: [
                              TextSpan(
                                text: pnl,
                              ),
                              TextSpan(
                                text: " (", // Open bracket
                              ),
                              TextSpan(
                                text: '${pnlPercentage?.toStringAsFixed(2)}%',
                                style: AppTextStyles.headline1.copyWith(
                                  color: pnlPercentage != null &&
                                          pnlPercentage!.isNegative
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
                  const SizedBox(height: 8),
                  Text(S.current.pnl)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
