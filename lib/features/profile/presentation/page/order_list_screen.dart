import 'dart:developer';

import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../core/core.dart';
import '../../../../features/profile/application/profile_provider.dart';
import 'order_detail_screen.dart';

class OrderListScreen extends HookConsumerWidget {
  static const route = '/order-list';

  const OrderListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getOrderListProvider);
    return Scaffold(
      backgroundColor: AppColors.bg100,
      appBar: const KAppBar(
        titleText: 'OrderList',
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(getOrderListProvider.future),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3,
              child: Row(
                mainAxisAlignment: mainSpaceAround,
                children: [
                  OrderDashboardItem(
                    title: 'TOTAL ORDER',
                    value: state.value?.length ?? 0,
                  ),
                  OrderDashboardItem(
                    title: 'TOTAL VALUE',
                    value: state.value
                            ?.map((element) => element.grand_total)
                            .reduce((value, element) => value + element) ??
                        0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: state.when(
                data: (data) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: AppColors.bg200,
                      child: KListViewSeparated(
                        padding: EdgeInsets.all(16.w),
                        separator: const Divider(
                          color: AppColors.bg300,
                        ),
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.bg200,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                // BoxShadow(
                                //   color: AppColors.black700.withOpacity(.2),
                                //   blurRadius: 0,
                                //   spreadRadius: 2,
                                //   offset: const Offset(0, 3),
                                // ),
                              ],
                            ),
                            child: KInkWell(
                              onTap: () {
                                context.push(OrderDetailScreen.route,
                                    extra: item);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: crossStart,
                                  children: [
                                    // const Icon(
                                    //   FontAwesome.list_check,
                                    //   size: 22,
                                    // ).py8(),
                                    Images.iconPriceList
                                        .assetImage(width: 38)
                                        .py8(),
                                    gap16,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          "Invoice No: "
                                              .richText
                                              .titleMedium(context)
                                              .bold
                                              .withTextSpanChildren([
                                            item.invoice_no.textSpan.make(),
                                          ]).make(),
                                          gap4,
                                          "Order Date: "
                                              .richText
                                              .bodyMedium(context)
                                              .withTextSpanChildren([
                                            item.sale_date.textSpan.make(),
                                          ]).make(),
                                          gap4,
                                          "Total Item: "
                                              .richText
                                              .bodyMedium(context)
                                              .withTextSpanChildren([
                                            item.total_qty
                                                .toString()
                                                .textSpan
                                                .make(),
                                          ]).make(),
                                        ],
                                      ),
                                    ),
                                    gap10,
                                    Column(
                                      mainAxisAlignment: mainCenter,
                                      mainAxisSize: mainMax,
                                      children: [
                                        Center(
                                          child: "Total: "
                                              .richText
                                              .bodyLarge(context)
                                              .withTextSpanChildren([
                                            "${item.grand_total} ${AppStrings.tkSymbol}"
                                                .textSpan
                                                .make(),
                                          ]).make(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: data.length,
                      ),
                    ),
                  );
                },
                error: (error, stacktrace) {
                  log(error.toString(), error: error, stackTrace: stacktrace);
                  return Text(error.toString());
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDashboardItem extends StatelessWidget {
  const OrderDashboardItem({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  final num value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      mainAxisSize: mainMin,
      children: [
        Text(
          title,
          style: CustomTextStyles.s18BoldBlack900,
        ),
        gap6,
        AnimatedDigitWidget(
          value: value, // or use controller
          textStyle: CustomTextStyles.s16w600,
        ),
      ],
    ).p16().box.shadowSm.rounded.colorScaffoldBackground(context).make();
  }
}
