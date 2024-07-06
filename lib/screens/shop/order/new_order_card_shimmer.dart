import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/utils/colors.dart';

import '../../../utils/app_common.dart';

class NewOrderCardShimmer extends StatelessWidget {
  const NewOrderCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width - 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              ShimmerWidget(
                baseColor: shimmerLightBaseColor,
                child: Container(
                  margin: const EdgeInsets.only(left: 16),
                  padding: const EdgeInsets.all(42),
                  decoration: boxDecorationDefault(border: const Border(top: BorderSide(color: Colors.transparent))),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => ShimmerWidget(
                        backgroundColor: isDarkMode.value ? shimmerDarkBaseColor : shimmerLightBaseColor,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ).paddingSymmetric(horizontal: 16, vertical: 4),
                    ),
                  ),
                ],
              ).expand(),
            ],
          ).paddingTop(25),
          ShimmerWidget(
            baseColor: shimmerLightBaseColor,
            child: Container(
              width: Get.width - 32,
              padding: const EdgeInsets.symmetric(vertical: 75),
              decoration: boxDecorationDefault(),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: ShimmerWidget(
              baseColor: shimmerLightBaseColor,
              child: Container(
                width: 100,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: boxDecorationDefault(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultRadius)),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ShimmerWidget(
              baseColor: shimmerLightBaseColor,
              child: Container(
                width: 100,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: boxDecorationDefault(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(defaultRadius)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
