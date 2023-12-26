import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../core/app_ui/app_ui.dart';
import '../../../../core/constant/constant.dart';
import '../../../common/presentation/product_grid_tile.dart';
import '../../application/home_provider.dart';

class HomeLatestProductWidget extends HookConsumerWidget {
  const HomeLatestProductWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final value =
        ref.watch(homeDataProvider).whenData((value) => value.newArrival);
    return Column(
      children: [
        Gap(42.h),
        "Latest Products".text.xl4.wide.makeCentered(),
        Gap(15.h),
        (!value.isLoading && (value.valueOrNull?.data.isEmpty ?? true))
            ? "No Product Found"
                .text.xl
                .bold
                .letterSpacing(1.2)
                .makeCentered()
                .p32()
                .color(AppColors.bg300)
            : GridView.builder(
                padding: paddingH20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 18.w,
                  childAspectRatio: 180 / 335,
                ),
                itemCount: value.valueOrNull?.data.length ?? 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final item = ref
                      .watch(homeDataProvider)
                      .whenData((value) => value.newArrival.data[index]);

                  return item.when(
                    data: (data) => ProductGridTile(data: data),
                    error: (error, stackTrace) {
                      log(error.toString(), stackTrace: stackTrace);
                      return Text(error.toString());
                    },
                    loading: () => const ProductGridShimmer(),
                  );
                },
              ),
        gap20,
        "View All Product"
            .text
            .xl2
            .semiBold
            .underline
            .letterSpacing(.8)
            .makeCentered(),
        Gap(45.h),
      ],
    ).color(AppColors.bg200);
  }
}
