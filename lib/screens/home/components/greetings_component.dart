import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/common_base.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../auth/other/notification_screen.dart';
import '../../pet/my_pets_controller.dart';
import 'dart:math';

import '../home_controller.dart';

class GreetingsComponent extends StatelessWidget {
  GreetingsComponent({super.key});

  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                '${locale.value.hello}, ${loginUserData.value.userName.isNotEmpty ? loginUserData.value.userName : locale.value.guest} 👋',
                style: primaryTextStyle(size: 20),
              ),
            ).paddingTop(16),
            Obx(
              () => Text(
                '${locale.value.howS} $randomPetName ${locale.value.healthGoingOn}',
                style: secondaryTextStyle(),
              ).visible(randomPetName.isNotEmpty),
            ).paddingTop(4),
          ],
        ),
        const Spacer(),
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Get.to(() => NotificationScreen());
              },
              icon: Assets.iconsIcUnselectedBell.iconImage(color: darkGray, size: 24),
            ).visible(isLoggedIn.value),
            Positioned(
              top: homeScreenController.dashboardData.value.notificationCount < 10 ? 5 : 4,
              right: homeScreenController.dashboardData.value.notificationCount < 10 ? 12 : 10,
              child: Obx(() => Container(
                padding: const EdgeInsets.all(4),
                decoration: boxDecorationDefault(color: primaryColor, shape: BoxShape.circle),
                child: Text(
                  '${homeScreenController.dashboardData.value.notificationCount}',
                  style: primaryTextStyle(size: homeScreenController.dashboardData.value.notificationCount < 10 ? 10 : 8, color: white),
                ),
              ).visible(homeScreenController.dashboardData.value.notificationCount > 0)),
            ),
          ],
        ).paddingTop(16),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  String get randomPetName {
    try {
      if (myPetsScreenController.myPets.isNotEmpty) {
        return myPetsScreenController.myPets[Random().nextInt(myPetsScreenController.myPets.length)].name;
      } else {
        return "";
      }
    } catch (e) {
      log('randomPetName E: $e');
      return "";
    }
  }
}
