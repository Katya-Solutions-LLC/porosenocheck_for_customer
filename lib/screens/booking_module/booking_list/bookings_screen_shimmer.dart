import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/booking_module/booking_list/booking_card_shimmer.dart';

class BookingsScreenShimmer extends StatelessWidget {
  const BookingsScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      shrinkWrap: true,
      itemCount: 10,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (BuildContext context, int index) {
        return const BookingCardShimmer(isFromHome: true);
      },
    );
  }
}
