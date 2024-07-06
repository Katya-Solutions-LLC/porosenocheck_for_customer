import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/screens/pet_sitter/pet_sitter_item_component_shimmer.dart';

class ChoosePetSitterHomeComponentsShimmer extends StatelessWidget {
  const ChoosePetSitterHomeComponentsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            return const PetSitterItemComponentShimmer();
          },
        )
      ],
    );
  }
}
