import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/utils/colors.dart';

class OrderDetailScreenShimmer extends StatelessWidget {
  const OrderDetailScreenShimmer({Key? key}) : super(key: key);

  Widget orderInformationWidgetShimmer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerWidget(padding: EdgeInsets.symmetric(horizontal: 48, vertical: 8)).paddingRight(120),
        16.height,
        Stack(
          alignment: Alignment.center,
          children: [
            ShimmerWidget(
              baseColor: shimmerLightBaseColor,
              child: Container(
                width: Get.width - 16,
                padding: const EdgeInsets.all(60),
                decoration: boxDecorationDefault(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  5,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ShimmerWidget(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ).expand(flex: 3),
                      const Spacer(),
                      const ShimmerWidget(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ).expand(flex: 3)
                    ],
                  ).paddingSymmetric(horizontal: 12, vertical: 2),
                ),
              ],
            ),
          ],
        )
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  Widget aboutProductComponentShimmer() {
    return Container(
      width: Get.width - 32,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  ShimmerWidget(
                    baseColor: shimmerLightBaseColor,
                    child: Container(
                      margin: const EdgeInsets.only(left: 16, top: 16),
                      padding: const EdgeInsets.all(42),
                      decoration: boxDecorationDefault(),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => const ShimmerWidget(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ).paddingSymmetric(horizontal: 16, vertical: 4),
                    ),
                  ).expand()
                ],
              ),
              ShimmerWidget(
                baseColor: shimmerLightBaseColor,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  padding: const EdgeInsets.all(24),
                  decoration: boxDecorationDefault(),
                ),
              )
            ],
          ).paddingTop(2).paddingBottom(2),
          ShimmerWidget(
            baseColor: shimmerLightBaseColor,
            child: Container(
              width: Get.width - 32,
              padding: const EdgeInsets.symmetric(vertical: 90),
              decoration: boxDecorationDefault(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.center,
      children: [
        orderInformationWidgetShimmer(),
        aboutProductComponentShimmer(),
        orderInformationWidgetShimmer(),
        orderInformationWidgetShimmer().paddingSymmetric(vertical: 16),
        orderInformationWidgetShimmer(),
      ],
    );
  }
}
