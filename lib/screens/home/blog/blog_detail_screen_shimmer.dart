import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/utils/colors.dart';

class BlogDetailScreenShimmer extends StatelessWidget {
  const BlogDetailScreenShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      crossAxisAlignment: CrossAxisAlignment.start,
      listAnimationType: ListAnimationType.None,
      children: [
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(120),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerWidget(
              baseColor: shimmerLightBaseColor,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                decoration: boxDecorationDefault(),
              ),
            ),
            ShimmerWidget(
              baseColor: shimmerLightBaseColor,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                decoration: boxDecorationDefault(),
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 12),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
            decoration: boxDecorationDefault(borderRadius: BorderRadius.zero),
          ),
        ),
        16.height,
        ...List.generate(
          4,
          (index) => ShimmerWidget(
            baseColor: shimmerLightBaseColor,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
              decoration: boxDecorationDefault(),
            ),
          ),
        ),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(150).paddingLeft(16),
        24.height,
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(150).paddingLeft(16),
        12.height,
        ...List.generate(
          4,
          (index) => ShimmerWidget(
            baseColor: shimmerLightBaseColor,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
              decoration: boxDecorationDefault(),
            ),
          ),
        ),
        24.height,
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(150).paddingLeft(16),
        12.height,
        ...List.generate(
          4,
          (index) => ShimmerWidget(
            baseColor: shimmerLightBaseColor,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
              decoration: boxDecorationDefault(),
            ),
          ),
        ),
      ],
    );
  }
}
