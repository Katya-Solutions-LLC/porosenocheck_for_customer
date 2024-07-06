import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/app_scaffold.dart';
import 'package:porosenocheck/components/html_widget.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/common_base.dart';

import '../../../components/cached_image_widget.dart';
import '../../../utils/colors.dart';
import 'blog_detail_controller.dart';

class BlogDetailScreen extends StatelessWidget {
  BlogDetailScreen({Key? key}) : super(key: key);
  final BlogDetailController blogDetailController = Get.put(BlogDetailController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.blogDetail,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 16, bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (blogDetailController.blogDetailFromArg.value.tags.isNotEmpty)
                  Text(
                    blogDetailController.blogDetailFromArg.value.tags,
                    style: secondaryTextStyle(color: primaryColor, fontStyle: FontStyle.italic, fontFamily: fontFamilyFontWeight600),
                  ),
                8.height,
                Text(blogDetailController.blogDetailFromArg.value.name, style: primaryTextStyle(size: 18)),
                8.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blogDetailController.blogDetailFromArg.value.createdAt.dateInMMMMDyyyyFormat,
                      style: primaryTextStyle(color: secondaryTextColor, size: 12),
                    ),
                    const Spacer(),
                    Text("${locale.value.readTime} : ${blogDetailController.blogDetailFromArg.value.description.calculateReadTime().minutes.inMinutes} ${locale.value.min}", style: primaryTextStyle(color: secondaryTextColor, size: 12)),
                  ],
                ),
                16.height,
              ],
            ).paddingSymmetric(horizontal: 16),
            Hero(
              tag: "${blogDetailController.blogDetailFromArg.value.blogImage}${blogDetailController.blogDetailFromArg.value.id}",
              child: CachedImageWidget(url: blogDetailController.blogDetailFromArg.value.blogImage, width: Get.width, fit: BoxFit.fitWidth),
            ),
            16.height,
            if (blogDetailController.blogDetailFromArg.value.description.isNotEmpty && !(blogDetailController.blogDetailFromArg.value.description.contains('<p>')))
              HtmlWidget(
                content: blogDetailController.blogDetailFromArg.value.description,
              ).paddingSymmetric(horizontal: 8)
            else
              NoDataWidget(
                title: locale.value.noDetailFound,
                subTitle: "${locale.value.thereAreCurrentlyNoDetails} this blog", //TODO: string
              ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ),
    );
  }
}
