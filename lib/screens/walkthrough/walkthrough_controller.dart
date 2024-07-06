// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';

import '../../generated/assets.dart';
import '../auth/other/option_screen.dart';
import 'model/walkthrough_model.dart';
import '../../utils/constants.dart';
import '../../utils/local_storage.dart';

class WalkthroughController extends GetxController {
  PageController pageController = PageController();

  RxInt currentPage = 0.obs;

  List<WalkThroughElementModel> walkthroughDetails = [
    WalkThroughElementModel(image: Assets.walkthroughImagesWalkImage1, title: locale.value.discoverPetCareExcellence, subTitle: locale.value.exploreAWorldOf),
    WalkThroughElementModel(image: Assets.walkthroughImagesWalkImage2, title: locale.value.empowerYourPetSWellness, subTitle: locale.value.elevateYourPetSWellBeing),
    WalkThroughElementModel(image: Assets.walkthroughImagesWalkImage3, title: locale.value.unleashPetHappinessWith, subTitle: locale.value.elevateYourPetSJoy),
  ];

  @override
  void onInit() {
    setValueToLocal(SharedPreferenceConst.FIRST_TIME, true);
    super.onInit();
  }

  void handleNext() {
    pageController.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
    if (currentPage.value == (walkthroughDetails.length - 1)) {
      Get.offAll(() => OptionScreen(), binding: BindingsBuilder(() {
        if (Get.context != null) {
          setStatusBarColor(Get.context!.primaryColor, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light);
        }
      }));
    }
  }

  void handleSkip() {
    Get.offAll(() => OptionScreen(), binding: BindingsBuilder(() {
      if (Get.context != null) {
        setStatusBarColor(Get.context!.primaryColor, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light);
      }
    }));
  }

  @override
  void onClose() {
    if (Get.context != null) {
      setStatusBarColor(Get.context!.primaryColor, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light);
    }
    super.onClose();
  }
}
