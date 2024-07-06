import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/utils/colors.dart';

import '../../../../utils/app_common.dart';

class CategoryItemComponentsShimmer extends StatelessWidget {
  const CategoryItemComponentsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 3 - 20,
      alignment: Alignment.center,
      decoration: boxDecorationDefault(color: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShimmerWidget(
            baseColor: isDarkMode.value ? shimmerDarkBaseColor : shimmerLightBaseColor,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 16),
              decoration: boxDecorationDefault(),
            ),
          ),
          ShimmerWidget(
            baseColor: isDarkMode.value ? shimmerDarkBaseColor : shimmerLightBaseColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
              decoration: boxDecorationDefault(),
            ),
          ).paddingSymmetric(horizontal: 16, vertical: 12)
        ],
      ),
    );
  }
}
