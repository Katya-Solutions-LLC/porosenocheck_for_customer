import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/app_common.dart';
import '../../components/app_scaffold.dart';
import '../../configs.dart';
import '../../generated/assets.dart';
import 'add_pet_info_controller.dart';
import '../../utils/colors.dart';

class AddPetSuccessScreen extends StatelessWidget {
  AddPetSuccessScreen({Key? key}) : super(key: key);
  final AddPetInfoController addPetInfoController = Get.find();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      body: Container(
        alignment: Alignment.center,
        height: Get.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: boxDecorationDefault(color: context.scaffoldBackgroundColor),
                child: Image.asset(Assets.imagesVector4),
              ),
              32.height,
              SizedBox(
                width: Get.width * 0.9,
                child: Text(
                  "${locale.value.youHaveSuccessfullyAdded}  $APP_NAME!",
                  /* '${locale.value.youHaveSuccessfullyAdded} $APP_NAME!',*/
                  textAlign: TextAlign.center,
                  style: secondaryTextStyle(
                    color: isDarkMode.value ? cardColor : primaryTextColor,
                    size: 22,
                    weight: FontWeight.w500,
                  ),
                ),
              ),
              16.height,
              SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  locale.value.youCanEnjoyOur,
                  textAlign: TextAlign.center,
                  style: secondaryTextStyle(color: secondaryTextColor),
                ),
              ),
              48.height,
              AppButton(
                width: Get.width,
                text: locale.value.done,
                textStyle: const TextStyle(color: containerColor),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
