import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/shop/order/components/product_review_dialog.dart';
import 'package:porosenocheck/utils/colors.dart';

import '../../../../components/cached_image_widget.dart';
import '../../../../components/dotted_line.dart';
import '../../../../components/zoom_image_screen.dart';
import '../../../../generated/assets.dart';
import '../../../../main.dart';
import '../../../../utils/common_base.dart';
import '../../../../utils/constants.dart';
import '../../../booking_module/booking_detail/booking_detail_controller.dart';
import '../../cart/model/cart_list_model.dart';
import '../../product/model/product_review_response.dart';
import '../order_detail_controller.dart';

class OrderReviewComponent extends StatelessWidget {
  final String? deliveryStatus;
  final CartListData productData;

  const OrderReviewComponent({super.key, this.deliveryStatus, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (deliveryStatus == OrderStatusConst.DELIVERED)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!productData.productReviewData.id.validate(value: -1).isNegative)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    DottedLine(lineThickness: 1, dashLength: 4, dashColor: context.dividerColor),
                    10.height,
                    Text(locale.value.yourReview, style: primaryTextStyle(size: 14)),
                    Row(
                      children: [
                        ...[
                          Icon(Icons.star, size: 14, color: getRatingBarColor(productData.productReviewData.rating.validate().toInt())),
                          4.width,
                          Text(
                            productData.productReviewData.rating.validate().toStringAsFixed(1).toString(),
                            style: primaryTextStyle(color: getRatingBarColor(productData.productReviewData.rating.validate().toInt()), size: 14, fontFamily: fontFamilyFontWeight600),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              try {
                                final OrderDetailController orderDetailController = Get.find();
                                orderDetailController.selectedOrderData(productData);
                                orderDetailController.selectedRating(productData.productReviewData.rating.validate().toDouble());
                                orderDetailController.reviewCont.text = productData.productReviewData.reviewMsg.validate();
                                showInDialog(
                                  context,
                                  contentPadding: EdgeInsets.zero,
                                  builder: (p0) {
                                    return ProductReviewDialog();
                                  },
                                );
                              } catch (e) {
                                toast(e.toString(), print: true);
                              }
                            },
                            child: TextIcon(
                              text: locale.value.edit,
                              textStyle: secondaryTextStyle(),
                              prefix: commonLeadingWid(imgPath: Assets.iconsIcEditReview, icon: Icons.edit, size: 10),
                              edgeInsets: EdgeInsets.zero,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              showConfirmDialogCustom(
                                context,
                                title: locale.value.deleteReview,
                                subTitle: locale.value.doYouWantToDeleteReview,
                                positiveText: locale.value.yes,
                                negativeText: locale.value.no,
                                dialogType: DialogType.DELETE,
                                onAccept: (p0) async {
                                  try {
                                    final OrderDetailController orderDetailController = Get.find();
                                    orderDetailController.selectedOrderData(productData);

                                    orderDetailController.deleteOrderReview();
                                  } catch (e) {
                                    toast(e.toString(), print: true);
                                  }
                                },
                              );
                            },
                            child: TextIcon(
                              text: locale.value.delete,
                              textStyle: secondaryTextStyle(color: cancelStatusColor),
                              prefix: commonLeadingWid(imgPath: Assets.iconsIcDelete, icon: Icons.delete, color: cancelStatusColor),
                              edgeInsets: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (productData.productReviewData.reviewMsg.validate().isNotEmpty)
                      Text(
                        productData.productReviewData.reviewMsg!,
                        style: secondaryTextStyle(),
                      ).paddingBottom(16),
                    AnimatedWrap(
                      spacing: 10,
                      runSpacing: 10,
                      itemCount: productData.productReviewData.gallery.validate().take(3).length,
                      itemBuilder: (ctx, index) {
                        ReviewGallaryData galleryData = productData.productReviewData.gallery.validate()[index];

                        return CachedImageWidget(
                          url: galleryData.fullUrl.validate(),
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                          radius: defaultRadius,
                        ).onTap(() {
                          if (galleryData.fullUrl.validate().isNotEmpty) {
                            ZoomImageScreen(
                              galleryImages: productData.productReviewData.gallery.validate().map((e) => e.fullUrl.validate()).toList(),
                              index: index,
                            ).launch(context);
                          }
                        });
                      },
                    ),
                  ],
                )
              else
                AppButton(
                  width: Get.width,
                  text: locale.value.addReview,
                  textStyle: appButtonTextStyleWhite,
                  onTap: () async {
                    try {
                      final OrderDetailController orderDetailController = Get.find();
                      orderDetailController.selectedOrderData(productData);
                      orderDetailController.selectedRating(0);
                      orderDetailController.reviewCont.clear();
                      orderDetailController.pickedFile = RxList();
                      showInDialog(
                        context,
                        contentPadding: EdgeInsets.zero,
                        builder: (p0) {
                          return ProductReviewDialog();
                        },
                      );
                    } catch (e) {
                      toast(e.toString(), print: true);
                    }
                  },
                ).paddingOnly(top: 16),
              8.height,
            ],
          ),
      ],
    );
  }
}
