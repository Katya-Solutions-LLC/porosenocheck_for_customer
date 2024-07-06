import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/utils/colors.dart';

import '../../../components/circle_widget.dart';
import '../../../utils/app_common.dart';

class FeaturedProductItemComponentShimmer extends StatelessWidget {
  const FeaturedProductItemComponentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2 - 24,
      decoration: boxDecorationDefault(color: context.cardColor),
      child: Stack(
        children: [
          Column(
            children: [
              ShimmerWidget(
                baseColor: isDarkMode.value ? shimmerDarkBaseColor : shimmerLightBaseColor,
                child: Container(
                  width: Get.width / 2 - 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 56),
                  decoration: boxDecorationDefault(borderRadius: BorderRadius.circular(0)),
                ),
              ).paddingSymmetric(horizontal: 16),
              16.height,
              ShimmerWidget(
                baseColor: isDarkMode.value ? shimmerDarkBaseColor : shimmerLightBaseColor,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                  decoration: boxDecorationDefault(),
                ),
              ),
              8.height,
              ShimmerWidget(
                baseColor: isDarkMode.value ? shimmerDarkBaseColor : shimmerLightBaseColor,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                  decoration: boxDecorationDefault(),
                ),
              ).paddingSymmetric(horizontal: 28),
              10.height,
            ],
          ).paddingSymmetric(horizontal: 16),
          Positioned(
            right: 8,
            top: 8,
            child: CircleWidget(
              circleColor: shimmerLightBaseColor,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: ShimmerWidget(
                child: Icon(
                  Icons.favorite_border_rounded,
                  size: 20,
                  color: shimmerPrimaryBaseColor.withOpacity(0.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
