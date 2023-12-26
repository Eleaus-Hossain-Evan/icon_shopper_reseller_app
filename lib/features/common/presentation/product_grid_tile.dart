import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/core.dart';
import '../../../features/product/application/product_provider.dart';
import '../../auth/application/auth_provider.dart';
import '../../product/domain/model/product_model.dart';
import '../../product/presentation/product_detail/product_detail_screen.dart';

class ProductGridTile extends HookConsumerWidget {
  const ProductGridTile({
    super.key,
    required this.data,
    this.defaultFont = 16,
  });

  final ProductModel data;
  final double defaultFont;

  @override
  Widget build(BuildContext context, ref) {
    final sellerTotalDiscount = ref.watch(authProvider).user.special_discount;

    final hasVariation =
        data.productVariationStatus == 1; //' product has variation or not

    //' regular price, if product has variation then showing variant regular price,
    //' otherwise showing product regular price
    final regularPrice = hasVariation
        ? data.productVariants?.first.regularPrice ?? 0
        : data.regularPrice;

    //' discount price
    final discountPrice =
        (regularPrice - (regularPrice * sellerTotalDiscount) / 100).toInt();
    return KInkWell(
      onTap: () {
        ref.read(slugProvider.notifier).update((state) => data.slug);
        context.push("${ProductDetailScreen.route}/${data.slug}");
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 384 / 572,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Ink(
                    color: Colors.transparent,
                    child: KCachedNetworkImageWdLoading(
                      imageUrl: data.image.first,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Visibility(
                    visible: data.newArrivalStatus == 1,
                    child: "New"
                        .text
                        .xs
                        .bold
                        .underline
                        .heightLoose
                        .white
                        .wide
                        .size((defaultFont - 2).sp)
                        .make()
                        .pSymmetric(h: AppSpacing.sm, v: AppSpacing.xxxs)
                        .box
                        .customRounded(radius4)
                        .color(const Color(0xFF1F2937))
                        .make(),
                  ),
                ),
              ],
            ),
          ),
          gap12,
          data.productName.text
              .letterSpacing(.8)
              .maxLines(1)
              .ellipsis
              .size(defaultFont.sp)
              .isIntrinsic
              .make(),
          // gap10,

          // Row(
          //   children: [
          //     Row(
          //       children: [
          //         "TK".text.xl.bold.gray400.lineThrough.make(),
          //         gap2,
          //         variant.regularPrice.text.xl.bold.gray400.lineThrough.make(),
          //         gap8,
          //       ],
          //     ).hide(isVisible: variant.discount > 0),
          //     "TK".text.xl2.colorPrimary(context).bold.make(),
          //     gap2,
          //     (variant.salePrice).text.xl2.bold.colorPrimary(context).make(),
          //   ],
          // ),
          Row(
            mainAxisAlignment: mainCenter,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    '৳ '
                        .textSpan
                        .semiBold
                        .size((defaultFont - 4).sp)
                        .lineThrough
                        .color(AppColors.black600)
                        .make(),
                    regularPrice
                        .toString()
                        .textSpan
                        .semiBold
                        .color(AppColors.black600)
                        .size(12.sp)
                        .lineThrough
                        .make(),
                  ],
                ),
              ).hide(isVisible: sellerTotalDiscount > 0),
              SizedBox(
                width: 4.w,
              ).hide(isVisible: sellerTotalDiscount > 0),
              Text.rich(
                TextSpan(
                  children: [
                    '৳ '
                        .textSpan
                        .semiBold
                        .size(defaultFont.sp)
                        .color(AppColors.primary200)
                        .make(),
                    discountPrice
                        .toString()
                        .textSpan
                        .semiBold
                        .size(defaultFont.sp)
                        .color(AppColors.primary200)
                        .make()
                  ],
                ),
              ),
            ],
          ),
          // product.toString().text.make(),
        ],
      ),
    );
  }
}

class ProductGridShimmer extends StatelessWidget {
  const ProductGridShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AspectRatio(
          aspectRatio: 384 / 572,
          child: VxSkeleton(),
        ),
        gap12,
        VxSkeleton(height: 12.h),
        gap12,
        VxSkeleton(height: 16.h),
      ],
    );
  }
}
