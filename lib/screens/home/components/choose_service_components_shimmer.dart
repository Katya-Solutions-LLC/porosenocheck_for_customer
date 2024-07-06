import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/screens/home/components/service_card_shimmer.dart';

class ChooseServiceComponentsShimmer extends StatelessWidget {
  const ChooseServiceComponentsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.height,
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerWidget(padding: EdgeInsets.symmetric(horizontal: 48, vertical: 8)),
            ShimmerWidget(padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8)),
          ],
        ).paddingOnly(left: 16, right: 16),
        24.height,
        HorizontalList(
          runSpacing: 16,
          spacing: 16,
          wrapAlignment: WrapAlignment.start,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 8,
          itemBuilder: (context, index) {
            return const ServiceCardShimmer();
          },
        )
      ],
    ).paddingSymmetric(vertical: 16);
  }
}
