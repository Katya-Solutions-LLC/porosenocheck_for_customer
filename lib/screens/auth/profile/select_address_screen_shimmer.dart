import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/circle_widget.dart';
import 'package:porosenocheck/components/screen_shimmer.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/utils/colors.dart';

import '../../../utils/app_common.dart';

class SelectAddressScreenShimmer extends StatelessWidget {
  const SelectAddressScreenShimmer({Key? key}) : super(key: key);

  Widget addressItemComponentShimmer(BuildContext ctx) {
    return Container(
      width: Get.width - 32,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: boxDecorationDefault(color: ctx.cardColor),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              ShimmerWidget(
                baseColor: isDarkMode.value ? shimmerDarkBaseColor : shimmerLightBaseColor,
                child: const CircleWidget(
                  padding: EdgeInsets.all(12),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => ShimmerWidget(
                    backgroundColor: isDarkMode.value ? shimmerDarkBaseColor : shimmerLightBaseColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ).paddingSymmetric(horizontal: 16, vertical: 4),
                ),
              ).expand(),
              ShimmerWidget(backgroundColor: isDarkMode.value ? shimmerDarkBaseColor : shimmerLightBaseColor, padding: const EdgeInsets.all(16)),
              16.width,
              ShimmerWidget(backgroundColor: isDarkMode.value ? shimmerDarkBaseColor : shimmerLightBaseColor, padding: const EdgeInsets.all(16))
            ],
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenShimmer(shimmerComponent: addressItemComponentShimmer(context).paddingLeft(16));
  }
}
