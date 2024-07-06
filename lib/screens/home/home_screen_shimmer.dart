import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/home/components/choose_service_components_shimmer.dart';
import 'package:porosenocheck/screens/home/components/featured_product_home_component_shimmer.dart';
import 'package:porosenocheck/screens/home/components/greetings_component_shimmer.dart';
import 'package:porosenocheck/screens/home/components/sliders_component_shimmer.dart';
import 'package:porosenocheck/screens/home/components/upcoming_appointment_components_shimmer.dart';
import 'package:porosenocheck/screens/pet_sitter/pet_sitter_home_components_shimmer.dart';

class HomeScreenShimmer extends StatelessWidget {
  final bool showGreeting;
  const HomeScreenShimmer({super.key, this.showGreeting = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      listAnimationType: ListAnimationType.None,
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        showGreeting ? const GreetingsComponentShimmer() : const Offstage(),
        const SlidersComponentShimmer(),
        const ChooseServiceComponentsShimmer(),
        const UpcomingAppointmentComponentShimmer(),
        const ChoosePetSitterHomeComponentsShimmer(),
        const FeaturedProductHomeComponentShimmer(),
      ],
    );
  }
}
