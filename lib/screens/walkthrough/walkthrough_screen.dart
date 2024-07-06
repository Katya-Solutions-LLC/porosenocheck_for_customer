import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/cached_image_widget.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/app_common.dart';

import 'walkthrough_controller.dart';
import '../../utils/colors.dart';

class WalkthroughScreen extends StatelessWidget {
  WalkthroughScreen({Key? key}) : super(key: key);
  final WalkthroughController walkthroughController = Get.put(WalkthroughController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode.value ? context.scaffoldBackgroundColor : containerColor,
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.04),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: walkthroughController.handleSkip,
              child: Text(locale.value.skip, style: primaryTextStyle(color: primaryColor)),
            ),
          ),
          SizedBox(height: Get.height * 0.025),
          PageView.builder(
            itemCount: walkthroughController.walkthroughDetails.length,
            controller: walkthroughController.pageController,
            onPageChanged: (int index) {
              walkthroughController.currentPage(index);
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width,
                    decoration: boxDecorationDefault(borderRadius: radius(50)),
                    child: CachedImageWidget(
                      url: walkthroughController.walkthroughDetails[index].image.validate(),
                      fit: BoxFit.cover,
                      radius: 10,
                    ),
                  ).paddingSymmetric(horizontal: 16).expand(),
                  SizedBox(height: Get.height * 0.042),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        walkthroughController.walkthroughDetails[index].title ?? "",
                        style: primaryTextStyle(
                          size: 20,
                        ),
                      ),
                      10.height,
                      Text(
                        walkthroughController.walkthroughDetails[index].subTitle ?? "",
                        style: secondaryTextStyle(),
                      ),
                      SizedBox(height: Get.height * 0.042),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                ],
              );
            },
          ).expand(),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List<Widget>.generate(
                    walkthroughController.walkthroughDetails.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          walkthroughController.pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Container(
                          height: 8,
                          width: walkthroughController.currentPage.value == index ? 20 : 8,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: primaryColor),
                            color: walkthroughController.currentPage.value == index ? primaryColor : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    walkthroughController.currentPage.value != (walkthroughController.walkthroughDetails.length - 1)
                        ? IconButton(
                            onPressed: walkthroughController.handleNext,
                            icon: const Icon(
                              Icons.double_arrow_sharp,
                              color: secondaryColor,
                            ),
                          )
                        : TextButton(
                            onPressed: walkthroughController.handleNext,
                            child: Text(
                              "Get Started",
                              style: boldTextStyle(color: primaryColor, size: 14),
                            ),
                          ),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
          ),
          SizedBox(height: Get.height * 0.02),
        ],
      ),
    );
  }
}
