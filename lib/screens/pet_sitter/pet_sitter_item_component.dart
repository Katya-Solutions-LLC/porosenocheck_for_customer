import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/cached_image_widget.dart';
import 'package:porosenocheck/generated/assets.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/colors.dart';
import 'package:porosenocheck/utils/common_base.dart';

import '../../utils/app_common.dart';
import 'employee_detail_screen.dart';
import 'pet_sitter_model.dart';

class PetSitterItemComponent extends StatelessWidget {
  final PetSitterItem petSitter;

  const PetSitterItemComponent({super.key, required this.petSitter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: petSitter.id > 0
          ? () {
              Get.to(() => EmployeeDetailScreen(), arguments: petSitter.id);
            }
          : null,
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: Get.width * 0.42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedImageWidget(
              url: petSitter.profileImage,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              circle: true,
            ),
            16.height,
            Text(petSitter.fullName, textAlign: TextAlign.center, style: boldTextStyle(size: 12)),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (petSitter.mobile.isEmpty) {
                      toast("${petSitter.fullName} ${locale.value.hasNotSharedTheir}");
                    } else {
                      launchCall(petSitter.mobile);
                    }
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: boxDecorationDefault(
                      color: isDarkMode.value ? darkGrayGeneral2 : lightPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: commonLeadingWid(imgPath: Assets.iconsCall, icon: Icons.mail_outlined, color: secondaryTextColor.withOpacity(isDarkMode.value ? 1 : 0.7)),
                  ),
                ),
                16.width,
                GestureDetector(
                  onTap: () {
                    log('PETSITTER.EMAIL: ${petSitter.email}');
                    if (petSitter.email.isEmpty) {
                      toast("${petSitter.fullName} ${locale.value.hasNotSharedTheirEmail}");
                    } else {
                      launchMail(petSitter.email);
                    }
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: boxDecorationDefault(
                        color: isDarkMode.value ? darkGrayGeneral2 : lightPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: commonLeadingWid(imgPath: Assets.iconsIcMail, icon: Icons.mail_outlined, color: secondaryTextColor.withOpacity(isDarkMode.value ? 1 : 0.7))),
                ),
              ],
            ),
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
