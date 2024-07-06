import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/screen_shimmer.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/utils/colors.dart';

import '../../../utils/app_common.dart';

class CartScreenShimmer extends StatelessWidget {
  const CartScreenShimmer({Key? key}) : super(key: key);

  Widget productInformationComponentShimmer(BuildContext ctx) {
    return SizedBox(
      width: Get.width - 32,
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShimmerWidget(
                    baseColor: shimmerLightBaseColor,
                    child: Container(
                      margin: const EdgeInsets.only(left: 16, top: 16),
                      padding: const EdgeInsets.all(36),
                      decoration: boxDecorationDefault(),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      2,
                      (index) => ShimmerWidget(
                        backgroundColor: isDarkMode.value ? shimmerDarkBaseColor : shimmerLightBaseColor,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ).paddingSymmetric(horizontal: 16, vertical: 4),
                    ),
                  ).paddingTop(8).expand()
                ],
              ),
              Row(
                children: [
                  ShimmerWidget(
                    baseColor: shimmerLightBaseColor,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(18),
                      decoration: boxDecorationDefault(),
                    ),
                  ).paddingRight(16),
                  ShimmerWidget(
                    baseColor: shimmerLightBaseColor,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                      decoration: boxDecorationDefault(),
                    ),
                  ),
                ],
              ).paddingTop(16).paddingSymmetric(horizontal: 16)
            ],
          ),
          ShimmerWidget(
            baseColor: shimmerLightBaseColor,
            child: Container(
              width: Get.width - 32,
              padding: const EdgeInsets.symmetric(vertical: 78),
              decoration: boxDecorationDefault(),
            ),
          )
        ],
      ),
    );
  }

  Widget productPriceDetailComponentShimmer() {
    return Stack(
      children: [
        Column(
          children: [
            ShimmerWidget(
              baseColor: shimmerLightBaseColor,
              child: Container(
                margin: const EdgeInsets.only(left: 16, top: 16, right: 140),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: boxDecorationDefault(),
              ),
            ).paddingBottom(16),
            ...List.generate(
              2,
              (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(
                    baseColor: shimmerLightBaseColor,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                      decoration: boxDecorationDefault(),
                    ),
                  ),
                  ShimmerWidget(
                    baseColor: shimmerLightBaseColor,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                      decoration: boxDecorationDefault(),
                    ),
                  )
                ],
              ).paddingSymmetric(horizontal: 16, vertical: 6),
            ),
            ShimmerWidget(
              baseColor: shimmerLightBaseColor,
              child: Container(
                margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
                padding: const EdgeInsets.all(24),
                decoration: boxDecorationDefault(),
              ),
            ),
          ],
        ),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 90),
            decoration: boxDecorationDefault(),
          ),
        ),
      ],
    ).cornerRadiusWithClipRRectOnly(topLeft: defaultRadius.toInt(), topRight: defaultRadius.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ScreenShimmer(
          shimmerComponent: productInformationComponentShimmer(context),
          itemCount: 2,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: productPriceDetailComponentShimmer(),
        )
      ],
    );
  }
}
