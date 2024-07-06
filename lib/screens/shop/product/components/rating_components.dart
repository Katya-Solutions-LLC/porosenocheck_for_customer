import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/screens/shop/product/components/all_review_product_components.dart';
import 'package:porosenocheck/screens/shop/shop_api.dart';
import 'package:porosenocheck/utils/view_all_label_component.dart';
import '../../../../components/cached_image_widget.dart';
import '../../../../components/dotted_line.dart';
import '../../../../components/zoom_image_screen.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';
import '../../../../utils/constants.dart';
import '../../../booking_module/booking_detail/booking_detail_controller.dart';
import '../../shop_dashboard/model/product_list_response.dart';
import '../model/product_review_response.dart';
import '../product_controller.dart';

class RatingComponents extends StatelessWidget {
  final List<ProductReviewDataModel> reviewDetails;
  final ProductItemData productReviewData;
  final ProductDetailController productController;

  const RatingComponents({super.key, required this.productController, required this.reviewDetails, required this.productReviewData});

  @override
  Widget build(BuildContext context) {
    if (productReviewData.productReview.validate().isEmpty) {
      return Text(locale.value.noRatingsYet, style: primaryTextStyle(fontFamily: fontFamilyBoldGlobal)).paddingSymmetric(horizontal: 16);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
            label: locale.value.ratingAndReviews,
            onTap: () {
              productController.init();
              Get.to(() => AllReviewProductComponents(productId: productReviewData.id, productController: productController));
            }),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Text(' ${locale.value.totalReviewsAndRatings} : ${productReviewData.ratingCount.validate()}', style: secondaryTextStyle()),
              4.height,
              Row(
                children: [
                  Text('${productReviewData.rating.validate()}', style: primaryTextStyle(size: 30)),
                  8.width,
                  RatingBarWidget(
                    onRatingChanged: (rating) {
                      //
                    },
                    disable: true,
                    activeColor: getRatingBarColor(productReviewData.rating.validate().toInt()),
                    inActiveColor: ratingBarColor,
                    rating: productReviewData.rating.validate().toDouble(),
                    size: 20,
                  ).expand(),
                ],
              ),
              4.height,
              DottedLine(dashGapLength: 0, dashColor: context.dividerColor),
              AnimatedWrap(
                children: List.generate(reviewDetails.take(4).length, (index) {
                  ProductReviewDataModel reviewData = reviewDetails[index];
                  return Column(
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
                          Text(reviewData.createdAt.validate().dateInyyyyMMddHHmmFormat.timeAgoWithLocalization, style: secondaryTextStyle()),
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
                                    icon: reviewData.isUserLike == 1 ? const Icon(Icons.thumb_up_alt_rounded, size: 15, color: primaryColor) : const Icon(Icons.thumb_up_alt_outlined, size: 16),
                                    onPressed: () async {
                                      /// Review Like Api
                                      if (reviewData.isUserLike != 1) {
                                        Map req = {
                                          ProductModelKey.reviewId: reviewData.id,
                                          ProductModelKey.isLike: 1,
                                        };
                                        doIfLoggedIn(context, () async {
                                          await ShopApi.addReviewLikeOrDislike(req).then((value) {
                                            toast(locale.value.thanksForVoting);
                                          }).catchError((error) {
                                            toast(error.toString());
                                          });
                                          productController.init();
                                        });
                                      }
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
                                      if (reviewData.isUserDislike != 1) {
                                        Map req = {
                                          ProductModelKey.reviewId: reviewData.id,
                                          ProductModelKey.isDislike: 1,
                                        };

                                        doIfLoggedIn(context, () async {
                                          await ShopApi.addReviewLikeOrDislike(req).then((value) {
                                            toast(locale.value.thanksForVoting);
                                          }).catchError((error) {
                                            toast(error.toString());
                                          });
                                          productController.init();
                                        });
                                      }
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
                  );
                }),
              ),
            ],
          ).paddingSymmetric(horizontal: 8),
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
