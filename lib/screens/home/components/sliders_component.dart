import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/common_base.dart';

import '../../../components/cached_image_widget.dart';
import '../home_controller.dart';

class SlidersComponent extends StatelessWidget {
  SlidersComponent({Key? key}) : super(key: key);
  final HomeScreenController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Obx(
            () => PageView.builder(
              controller: dashboardController.pageController,
              onPageChanged: (int page) {
                hideKeyboard(context);
                dashboardController.currentPage(page);
              },
              itemCount: dashboardController.dashboardData.value.slider.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (dashboardController.dashboardData.value.slider[index].link.isURL) commonLaunchUrl(dashboardController.dashboardData.value.slider[index].link, launchMode: LaunchMode.externalApplication);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    color: Colors.transparent,
                    width: Get.width,
                    child: CachedImageWidget(
                      url: dashboardController.dashboardData.value.slider[index].sliderImage,
                      fit: BoxFit.fitWidth,
                      usePlaceholderIfUrlEmpty: false,
                      width: Get.width,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 28,
            left: 16,
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List<Widget>.generate(
                    dashboardController.dashboardData.value.slider.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          dashboardController.pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        },
                        child: Obx(
                          () => Container(
                            height: 8,
                            width: dashboardController.currentPage.value == index ? 20 : 10,
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: white),
                              color: dashboardController.currentPage.value == index ? containerColor : primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
