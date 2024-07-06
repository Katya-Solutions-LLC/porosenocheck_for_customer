import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/cached_image_widget.dart';

import '../add_pet_info_controller.dart';
import '../../../utils/colors.dart';

class StepNoWid extends StatelessWidget {
  final int stepNo;
  final bool isActive;

  const StepNoWid({
    Key? key,
    required this.stepNo,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 28,
      alignment: Alignment.center,
      // padding: const EdgeInsets.all(10),
      decoration: boxDecorationDefault(
        shape: BoxShape.circle,
        color: isActive ? secondaryColor : context.cardColor,
      ),
      child: Text('$stepNo', style: primaryTextStyle(color: isActive ? context.cardColor : lightGrayGeneral)),
    );
  }
}

class StepsRow extends StatelessWidget {
  final String midImg1;
  final String midImg2;
  final bool isStep2Active;
  final bool isStep3Active;

  StepsRow({
    super.key,
    required this.midImg1,
    required this.midImg2,
    this.isStep2Active = false,
    this.isStep3Active = false,
  });

  final AddPetInfoController addPetInfoController = Get.put(AddPetInfoController());

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (addPetInfoController.isUpdateProfile.value || (!isStep2Active && !isStep3Active))
          const StepNoWid(stepNo: 1, isActive: true)
        else
          CachedImageWidget(
            url: addPetInfoController.selectedPetType.value.pettypeImage,
            height: 30,
            width: 30,
            circle: true,
            fit: BoxFit.cover,
          ),
        16.width,
        Image(image: AssetImage(midImg1)),
        16.width,
        StepNoWid(stepNo: 2, isActive: isStep2Active),
        16.width,
        Image(image: AssetImage(midImg2)),
        16.width,
        StepNoWid(stepNo: 3, isActive: isStep3Active),
      ],
    );
  }
}
