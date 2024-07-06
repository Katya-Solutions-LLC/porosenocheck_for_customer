import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/screen_shimmer.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/utils/colors.dart';

import '../../../utils/app_common.dart';

class BookingDetailScreenShimmer extends StatelessWidget {
  const BookingDetailScreenShimmer({Key? key}) : super(key: key);

  Widget customerInformationComponentShimmer(BuildContext ctx) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWidget(
          baseColor: isDarkMode.value ? shimmerDarkBaseColor : null,
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
        ),
        16.height,
        Stack(
          children: [
            Container(
              height: 130,
              width: Get.width - 16,
              padding: const EdgeInsets.all(16),
              decoration: boxDecorationDefault(color: ctx.cardColor),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                16.height,
                ...List.generate(
                  5,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => ShimmerWidget(
                          baseColor: isDarkMode.value ? shimmerDarkBaseColor : null,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ).expand(flex: 3),
                      ),
                      const Spacer(),
                      Obx(
                        () => ShimmerWidget(
                          baseColor: isDarkMode.value ? shimmerDarkBaseColor : null,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ).expand(flex: 3),
                      )
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

  @override
  Widget build(BuildContext context) {
    return ScreenShimmer(
      itemCount: 5,
      shimmerComponent: customerInformationComponentShimmer(context),
    );
  }
}
