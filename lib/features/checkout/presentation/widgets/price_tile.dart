import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';

class PriceTile extends HookConsumerWidget {
  const PriceTile({
    super.key,
    required this.title,
    required this.price,
    this.isTotal = false,
    this.isPercentage = false,
  });
  final String title;
  final num price;
  final bool isTotal;
  final bool isPercentage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: mainSpaceBetween,
      children: [
        Text(
          title,
          style: isTotal
              ? const TextStyle(
                  fontSize: AppSpacing.spaceUnit,
                  fontWeight: FontWeight.w600,
                )
              : null,
        ),
        Text(
          "${isPercentage ? "" : AppStrings.tkSymbol} $price ${isPercentage ? "%" : ""}",
          style: isTotal
              ? const TextStyle(
                  fontSize: AppSpacing.spaceUnit,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                )
              : null,
        ),
      ],
    );
  }
}
