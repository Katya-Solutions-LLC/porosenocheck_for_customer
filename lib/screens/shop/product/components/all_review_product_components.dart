import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/app_scaffold.dart';
import 'package:porosenocheck/screens/shop/shop_api.dart';
import '../../../../components/cached_image_widget.dart';
import '../../../../components/loader_widget.dart';
import '../../../../components/zoom_image_screen.dart';
import '../../../../main.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/empty_error_state_widget.dart';
import '../../../booking_module/booking_detail/booking_detail_controller.dart';
import '../model/product_review_response.dart';
import '../product_controller.dart';

class AllReviewProductComponents extends StatelessWidget {
  final int? productId;
  final ProductDetailController productController;

  const AllReviewProductComponents({super.key, required this.productController, this.productId});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBartitleText: locale.value.productReviews,
        body: Obx(
          () => SnapHelperWidget<List<ProductReviewDataModel>>(
            future: productController.getreview.value,
            loadingWidget: const LoaderWidget(),
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                imageWidget: const ErrorStateWidget(),
                retryText: locale.value.reload,
                onRetry: () {
                  productController.page = 1;
                  productController.isLoading(true);
                  productController.init();
                },
              );
            },
            onSuccess: (reviewListData) {
              return AnimatedListView(
                shrinkWrap: true,
                listAnimationType: ListAnimationType.FadeIn,
                padding: const EdgeInsets.all(16),
                itemCount: reviewListData.length,
                physics: const AlwaysScrollableScrollPhysics(),
                emptyWidget: NoDataWidget(
                  title: locale.value.noReviewsFound,
                  imageWidget: const EmptyStateWidget(),
                ),
                itemBuilder: (context, index) {
                  ProductReviewDataModel reviewData = reviewListData[index];

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: Get.width,
                    decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  alignment: Alignment.center,
                                  decoration: boxDecorationWithRoundedCorners(backgroundColor: context.scaffoldBackgroundColor),
                                  child: TextIcon(
                                    text: reviewData.rating.validate().toString(),
                                    edgeInsets: const EdgeInsets.only(left: 0),
                                    textStyle: boldTextStyle(size: 14, color: primaryColor),
                                    prefix: Icon(Icons.star, size: 10, color: getRatingBarColor(reviewData.rating.validate().toInt())),
                                  ),
                                ),
                                8.width,
                                Marquee(child: Text(reviewData.userName.validate(), style: primaryTextStyle(size: 14))).flexible(),
                              ],
                            ).expand(),
                            8.width,
                            reviewData.createdAt.validate().dateInyyyyMMddHHmmFormat.timeAgoWithLocalization.isNotEmpty
                                ? Text(reviewData.createdAt.validate().dateInyyyyMMddHHmmFormat.timeAgoWithLocalization, style: secondaryTextStyle())
                                : const SizedBox(),
                          ],
                        ),
                        14.height,
                        ReadMoreText(reviewData.reviewMsg.validate(), style: boldTextStyle(size: 12)),
                        16.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedWrap(
                              spacing: 10,
                              runSpacing: 10,
                              itemCount: reviewData.reviewGallary.validate().take(3).length,
                              itemBuilder: (ctx, index) {
                                ReviewGallaryData galleryData = reviewData.reviewGallary.validate()[index];

                                return CachedImageWidget(
                                  url: galleryData.fullUrl.validate(),
                                  width: 45,
                                  height: 45,
                                  fit: BoxFit.cover,
                                  radius: defaultRadius,
                                ).onTap(() {
                                  if (galleryData.fullUrl.validate().isNotEmpty) {
                                    ZoomImageScreen(
                                      galleryImages: reviewData.reviewGallary.validate().map((e) => e.fullUrl.validate()).toList(),
                                      index: index,
                                    ).launch(context);
                                  }
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      icon: reviewData.isUserLike == 1 ? const Icon(Icons.thumb_up_alt_rounded, size: 15, color: primaryColor) : const Icon(Icons.thumb_up_alt_outlined, size: 16),
                                      onPressed: () async {
                                        /// Review Like Api

                                        doIfLoggedIn(context, () async {
                                          if (reviewData.isUserLike != 1) {
                                            Map req = {
                                              ProductModelKey.reviewId: reviewData.id,
                                              ProductModelKey.isLike: 1,
                                            };

                                            await ShopApi.addReviewLikeOrDislike(req).then((value) {
                                              toast(locale.value.thanksForVoting);
                                            }).catchError((error) {
                                              toast(error.toString());
                                            });
                                            /*  onProductDetailUpdate.call();*/
                                            productController.init();
                                          }
                                        });
                                      },
                                    ),
                                    Text('${reviewData.reviewLikes}', style: secondaryTextStyle()),
                                  ],
                                ),
                                4.width,
                                Row(
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: reviewData.isUserDislike == 1 ? const Icon(Icons.thumb_down_alt_rounded, size: 15, color: primaryColor) : const Icon(Icons.thumb_down_alt_outlined, size: 16),
                                      onPressed: () async {
                                        /// Review DisLike Api

                                        doIfLoggedIn(context, () async {
                                          if (reviewData.isUserDislike != 1) {
                                            Map req = {
                                              ProductModelKey.reviewId: reviewData.id,
                                              ProductModelKey.isDislike: 1,
                                            };

                                            await ShopApi.addReviewLikeOrDislike(req).then((value) {
                                              toast(locale.value.thanksForVoting);
                                            }).catchError((error) {
                                              toast(error.toString());
                                            });
                                            /* onProductDetailUpdate.call();*/
                                            productController.init();
                                          }
                                        });
                                      },
                                    ),
                                    Text('${reviewData.reviewDislikes}', style: secondaryTextStyle()),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        16.height,
                      ],
                    ),
                  );
                },
                onNextPage: () {
                  if (!productController.isLastPage.value) {
                    productController.page++;
                    productController.isLoading(true);
                    productController.init();
                    Future.delayed(const Duration(seconds: 2), () {
                      productController.isLoading(false);
                    });
                  }
                },
                onSwipeRefresh: () async {
                  productController.page = 1;
                  productController.init();
                  return await Future.delayed(const Duration(seconds: 2));
                },
              );
            },
          ),
        ));
  }
}
