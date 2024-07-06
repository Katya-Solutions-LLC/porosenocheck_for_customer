import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/utils/colors.dart';

class EventItemComponentShimmer extends StatelessWidget {
  final double? width;
  const EventItemComponentShimmer({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width - 32,
      decoration: boxDecorationDefault(),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ShimmerWidget(
                          baseColor: shimmerLightBaseColor,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                            decoration: boxDecorationDefault(),
                          ),
                        ),
                        ShimmerWidget(
                          baseColor: shimmerLightBaseColor,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                            decoration: boxDecorationDefault(),
                          ),
                        ).paddingTop(8)
                      ],
                    ),
                    ShimmerWidget(
                      baseColor: shimmerLightBaseColor,
                      child: VerticalDivider(
                        color: shimmerLightBaseColor,
                      ),
                    ),
                    Column(
                      children: [
                        ShimmerWidget(
                          baseColor: shimmerLightBaseColor,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                            decoration: boxDecorationDefault(),
                          ),
                        ),
                        ShimmerWidget(
                          baseColor: shimmerLightBaseColor,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                            decoration: boxDecorationDefault(),
                          ),
                        ),
                        ShimmerWidget(
                          baseColor: shimmerLightBaseColor,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                            decoration: boxDecorationDefault(),
                          ),
                        )
                      ],
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
          ).paddingSymmetric(horizontal: 16, vertical: 16),
          ShimmerWidget(
            baseColor: shimmerLightBaseColor,
            child: Container(
              width: Get.width - 32,
              height: 200,
              decoration: boxDecorationDefault(),
            ),
          )
        ],
      ),
    );
  }
}
