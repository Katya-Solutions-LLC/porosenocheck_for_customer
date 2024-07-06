import 'package:flutter/material.dart';
import 'package:porosenocheck/screens/pet_sitter/pet_sitter_item_component_shimmer.dart';

class PetSitterListShimmer extends StatelessWidget {
  const PetSitterListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      alignment: WrapAlignment.center,
      children: List.generate(
        10,
        (index) => const PetSitterItemComponentShimmer(),
      ),
    );
  }
}
