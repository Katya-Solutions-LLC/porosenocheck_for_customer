// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/screens/pet/add_pet_pageview.dart';
import 'package:porosenocheck/utils/app_common.dart';

import '../../../components/cached_image_widget.dart';
import '../../pet/my_pets_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../pet/model/pet_list_res_model.dart';

Rx<PetData> selectedPet = PetData().obs;

class ChooseYourPet extends StatelessWidget {
  const ChooseYourPet({
    super.key,
    required this.onChanged,
  });

  final Function(PetData) onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(locale.value.chooseYourPet, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
          8.height,
          Obx(
            () => SnapHelperWidget(
              future: myPetsScreenController.getPets.value,
              initialData: myPetsScreenController.myPets.isNotEmpty && !myPetsScreenController.myPets.first.id.isNegative ? myPetsScreenController.myPets : null,
              errorBuilder: (error) {
                return NoDataWidget(
                  title: error,
                  retryText: locale.value.reload,
                  titleTextStyle: primaryTextStyle(),
                ).paddingSymmetric(horizontal: 32);
              },
              loadingWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${locale.value.loading}... ", style: secondaryTextStyle(size: 14, fontFamily: fontFamilyFontBold)),
                ],
              ),
              onSuccess: (pets) {
                return pets.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppButton(
                            text: isLoggedIn.value ? locale.value.addYourPet : locale.value.signIn,
                            textStyle: secondaryTextStyle(color: primaryColor, fontFamily: fontFamilyFontBold),
                            color: lightPrimaryColor2,
                            onTap: () {
                              if (isLoggedIn.value) {
                                Get.to(() => AddPetInfoScreen(), arguments: true);
                              } else {
                                doIfLoggedIn(context, () {
                                  myPetsScreenController.init();
                                });
                              }
                            },
                          ).expand(),
                        ],
                      ).paddingSymmetric(horizontal: 32)
                    : HorizontalList(
                        itemCount: pets.length,
                        spacing: 16,
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        itemBuilder: (context, index) {
                          afterBuildCreated(() {
                            if (myPetsScreenController.myPets.length == 1) {
                              /// Pet Selection When there is only single pet
                              selectedPet(myPetsScreenController.myPets.first);
                            } else {
                              /// Pet Selection When From Rescheduling
                              selectedPet(myPetsScreenController.myPets.firstWhere((element) => element.id == selectedPet.value.id, orElse: () => PetData()));
                            }
                          });
                          // bool isSelected = boardingPetController.petSelectIndex == index;
                          return Obx(
                            () => InkWell(
                              onTap: () {
                                selectedPet(pets[index]);
                                onChanged.call(pets[index]);
                              },
                              borderRadius: radius(),
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                decoration: boxDecorationDefault(
                                  color: selectedPet.value == pets[index] ? lightPrimaryColor : context.cardColor,
                                ),
                                child: Row(
                                  children: [
                                    CachedImageWidget(
                                      url: pets[index].petImage,
                                      height: 24,
                                      width: 24,
                                      circle: true,
                                      radius: 24,
                                      fit: BoxFit.cover,
                                    ),
                                    8.width,
                                    Text(pets[index].name, style: secondaryTextStyle(color: selectedPet.value == pets[index] ? primaryColor : null)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
