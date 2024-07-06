import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/shop/order/order_apis.dart';
import 'package:porosenocheck/utils/colors.dart';

import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../../../utils/getImage.dart';
import '../cart/model/cart_list_model.dart';
import '../product/model/product_review_response.dart';
import '../shop_dashboard/model/product_list_response.dart';
import 'model/order_detail_model.dart';

class OrderDetailController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Future<OrderDetailModel>> getOrderDetailFuture = Future(() => OrderDetailModel(data: OrderListData(orderDetails: OrderDetails(productDetails: CartListData(qty: 0.obs, productVariation: VariationData(inCart: false.obs), productReviewData: ProductReviewDataModel()))))).obs;
  Rx<CartListData> selectedOrderData = CartListData(productVariation: VariationData(inCart: false.obs), qty: 0.obs, productReviewData: ProductReviewDataModel()).obs;
  RxString orderCode = "".obs;

  TextEditingController reviewCont = TextEditingController();
  RxBool isUpdate = false.obs;
  RxDouble selectedRating = 0.0.obs;
  RxList<XFile> pickedFile = RxList();

  @override
  void onInit() {
    if (Get.arguments is OrderListData) {
      orderCode((Get.arguments as OrderListData).orderCode);
    } else if (Get.arguments is CartListData) {
      orderCode((Get.arguments as CartListData).orderCode);
    }

    if (selectedOrderData.value.productReviewData.id != null) {
      selectedRating(selectedOrderData.value.productReviewData.rating.validate().toDouble());
      reviewCont.text = selectedOrderData.value.productReviewData.reviewMsg.validate();
    }
    init();
    super.onInit();
  }

  Future<void> init() async {
    try {
      if (Get.arguments is OrderListData) {
        await getOrderDetailFuture(
          OrderApis.getOrderDetail(
            orderId: (Get.arguments as OrderListData).orderDetails.productDetails.orderId,
            orderItemId: (Get.arguments as OrderListData).orderDetails.productDetails.id,
          ),
        ).then((value) {
          isLoading(false);
        });
      }

      if (Get.arguments is CartListData) {
        await getOrderDetailFuture(
          OrderApis.getOrderDetail(
            orderId: (Get.arguments as CartListData).orderId,
            orderItemId: (Get.arguments as CartListData).id,
            noteId: (Get.arguments as CartListData).notificationId,
          ),
        ).then((value) {
          isLoading(false);
        });
      }
    } catch (e) {
      toast(e.toString());
    }
  }

  deleteOrderReview() async {
    isLoading(true);
    await OrderApis.deleteOrderReview(id: selectedOrderData.value.productReviewData.id.validate()).then((value) {
      isLoading(false);
      init();
      toast(value.message);
    }).catchError((e) {
      toast(e.toString());
    });
  }

  void submit() async {
    hideKeyBoardWithoutContext();

    isLoading(true);

    await OrderApis.updateOrderReview(
      files: pickedFile.validate(),
      reviewId: selectedOrderData.value.productReviewData.id != null ? selectedOrderData.value.productReviewData.id.toString() : '',
      productId: selectedOrderData.value.productId.toString(),
      employeeId: selectedOrderData.value.employeeId.toString(),
      productVariationId: selectedOrderData.value.productVariationId.toString(),
      rating: selectedRating.value.toString(),
      reviewMsg: reviewCont.text.validate(),
      onSuccess: (data) {
        isLoading(false);
        Get.back();
        init();
        toast(locale.value.thankYouForReview);
      },
    ).catchError((e) {
      isLoading(false);
      toast(e.toString());
      Get.back(result: false);
    });
  }

  Future<void> _handleGalleryClick() async {
    Get.back();
    GetMultipleImage(path: (xFiles) async {
      log('Path Gallery : ${xFiles.length.toString()}');
      final existingNames = pickedFile.map((file) => file.name.trim().toLowerCase()).toSet();
      pickedFile.addAll(xFiles.where((file) => !existingNames.contains(file.name.trim().toLowerCase())));
    });
  }

  Future<void> _handleCameraClick() async {
    Get.back();
    GetImage(ImageSource.camera, path: (path, name, xFile) async {
      log('Path Camera : ${path.toString()} name $name');
      pickedFile.add(xFile);
    });
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: context.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SettingItemWidget(
              title: locale.value.gallery,
              leading: const Icon(Icons.image, color: primaryColor),
              onTap: () async {
                _handleGalleryClick();
              },
            ),
            SettingItemWidget(
              title: locale.value.camera,
              leading: const Icon(Icons.camera, color: primaryColor),
              onTap: () {
                _handleCameraClick();
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ],
        ).paddingAll(16.0);
      },
    );
  }
}
