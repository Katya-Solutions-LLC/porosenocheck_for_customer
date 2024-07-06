import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/view_all_label_component.dart';

import '../../main.dart';
import '../home/home_controller.dart';
import 'pet_sitter_item_component.dart';
import 'pet_sitter_list.dart';

class ChoosePetSitterComponents extends StatelessWidget {
  ChoosePetSitterComponents({Key? key}) : super(key: key);
  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.height,
        ViewAllLabel(
          label: locale.value.petSitter,
          list: homeScreenController.dashboardData.value.petSitter,
          onTap: () {
            Get.to(() => PetSitterListScreen());
          },
        ).visible(homeScreenController.dashboardData.value.petSitter.isNotEmpty).paddingOnly(left: 16, right: 8),
        8.height,
        HorizontalList(
          runSpacing: 16,
          spacing: 16,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: homeScreenController.dashboardData.value.petSitter.length,
          itemBuilder: (context, index) {
            return PetSitterItemComponent(petSitter: homeScreenController.dashboardData.value.petSitter[index]);
          },
        ),
      ],
    );
  }
}
