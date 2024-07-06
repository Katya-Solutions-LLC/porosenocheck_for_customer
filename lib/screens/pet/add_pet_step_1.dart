import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'add_pet_info_controller.dart';
import 'components/choose_components.dart';
import 'model/pet_type_model.dart';

class AddPetStep1Screen extends StatelessWidget {
  AddPetStep1Screen({Key? key}) : super(key: key);

  final AddPetInfoController addPetInfoController = Get.put(AddPetInfoController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        16.height,
        Obx(
          () => AnimatedWrap(
            runSpacing: 16,
            spacing: 16,
            children: List.generate(
              addPetInfoController.petTypeList.length,
              (index) {
                ChoosePetModel choosePet = addPetInfoController.petTypeList[index];

                return ChoosePet(choosePet: choosePet);
              },
            ),
          ),
        )
      ],
    ).paddingOnly(left: 16);
  }
}
