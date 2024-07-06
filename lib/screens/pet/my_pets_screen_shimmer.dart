import 'package:flutter/material.dart';
import 'package:porosenocheck/components/screen_shimmer.dart';
import 'package:porosenocheck/screens/pet/components/pet_card_component_shimmer.dart';

class MyPetsScreenShimmer extends StatelessWidget {
  const MyPetsScreenShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenShimmer(shimmerComponent: PetCardComponentShimmer());
  }
}
