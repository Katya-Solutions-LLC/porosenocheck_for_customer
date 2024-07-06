import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/view_all_label_component.dart';

import '../../../utils/app_common.dart';
import '../home_controller.dart';
import 'blog_list_screen.dart';
import 'blog_item_component.dart';

class BlogHomeComponent extends StatelessWidget {
  BlogHomeComponent({Key? key}) : super(key: key);
  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          16.height,
          ViewAllLabel(
            label: locale.value.blogs,
            onTap: () {
              Get.to(() => BlogListScreen());
            },
          ).paddingOnly(left: 16, right: 8),
          8.height,
          Obx(
            () => AnimatedListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              emptyWidget: NoDataWidget(
                title: locale.value.noBlogsFound,
                subTitle: locale.value.thereAreNoBlogs,
                retryText: locale.value.reload,
                onRetry: () {
                  homeScreenController.init();
                  Future.delayed(const Duration(seconds: 2), () {
                    homeScreenController.isLoading(false);
                  });
                },
              ).paddingSymmetric(horizontal: 16),
              itemCount: homeScreenController.dashboardData.value.blog.length,
              itemBuilder: (context, index) {
                return BlogItemComponent(blog: homeScreenController.dashboardData.value.blog[index]).paddingSymmetric(horizontal: 16);
              },
            ),
          )
        ],
      ).visible(appConfigs.value.isBlog && homeScreenController.dashboardData.value.blog.isNotEmpty),
    );
  }
}
