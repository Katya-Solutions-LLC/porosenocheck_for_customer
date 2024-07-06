import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/utils/colors.dart';

class BlogItemComponentShimmer extends StatelessWidget {
  const BlogItemComponentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 32,
      decoration: boxDecorationDefault(),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            right: 0,
            child: Row(
              children: [
                ShimmerWidget(
                  baseColor: shimmerLightBaseColor,
                  child: Container(
                    width: 100,
                    decoration: boxDecorationDefault(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(defaultRadius),
                        bottomLeft: Radius.circular(defaultRadius),
                      ),
                    ),
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
          ),
          ShimmerWidget(
            baseColor: shimmerLightBaseColor,
            child: Container(
              width: Get.width - 32,
              padding: const EdgeInsets.symmetric(vertical: 48),
              decoration: boxDecorationDefault(),
            ),
          )
        ],
      ),
    );
  }
}
