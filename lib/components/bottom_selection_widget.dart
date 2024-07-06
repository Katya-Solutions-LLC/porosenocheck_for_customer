import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stream_transform/stream_transform.dart';

import '../generated/assets.dart';
import '../main.dart';
import '../utils/common_base.dart';
import '../utils/empty_error_state_widget.dart';
import 'loader_widget.dart';

class BSScontroller extends GetxController {
  BSScontroller({this.searchApiCall});

  TextEditingController searchCont = TextEditingController();
  RxBool isSearchText = false.obs;

  StreamController<String> searchStream = StreamController<String>();
  final _scrollController = ScrollController();
  final Function(String)? searchApiCall;

  @override
  void onInit() {
    _scrollController.addListener(() => Get.context != null ? hideKeyboard(Get.context) : null);
    searchStream.stream.debounce(const Duration(seconds: 1)).listen((s) {
      searchApiCall?.call(s);
    });
    super.onInit();
  }

  @override
  void onClose() {
    searchStream.close();
    if (Get.context != null) {
      _scrollController.removeListener(() => hideKeyboard(Get.context));
    }
    super.onClose();
  }
}

class BottomSelectionSheet extends StatelessWidget {
  final String title;
  final String? hintText;
  final String? noDataTitle;
  final String? noDataSubTitle;
  final String? errorText;
  final bool hasError;
  final bool isEmpty;
  final RxBool? isLoading;
  final void Function()? onRetry;
  final TextEditingController? searchTextCont;
  final Function(String)? onChanged;
  final Widget listWidget;
  final bool hideSearchBar;
  final double heightRatio;
  final Function(String)? searchApiCall;

  const BottomSelectionSheet({
    super.key,
    required this.title,
    this.hintText,
    required this.listWidget,
    this.noDataTitle,
    this.noDataSubTitle,
    this.errorText,
    this.searchTextCont,
    required this.hasError,
    required this.isEmpty,
    this.onRetry,
    this.onChanged,
    this.isLoading,
    this.hideSearchBar = false,
    this.heightRatio = 0.80,
    this.searchApiCall,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BSScontroller(searchApiCall: searchApiCall),
      builder: (getxBSSCont) {
        return WillPopScope(
          onWillPop: () {
            handleCloseClick(context, getxBSSCont);
            return Future(() => true);
          },
          child: GestureDetector(
            onTap: () => hideKeyboard(context),
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: Get.width,
              constraints: BoxConstraints(minWidth: Get.height * 0.65, maxHeight: Get.height * heightRatio),
              /* padding: const EdgeInsets.donly(left: 5, right: 5),
                  margin: const EdgeInsets.only(left: 5, right: 5), */
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      54.height,
                      bottomSheetDivider,
                      AppTextField(
                        controller: getxBSSCont.searchCont,
                        textStyle: secondaryTextStyle(size: 14, color: textPrimaryColorGlobal),
                        textFieldType: TextFieldType.OTHER,
                        onChanged: (p0) {
                          onChanged?.call(p0);
                          getxBSSCont.isSearchText(getxBSSCont.searchCont.text.trim().isNotEmpty);
                          getxBSSCont.searchStream.add(p0);
                        },
                        decoration: inputDecorationWithOutBorder(
                          context,
                          hintText: hintText ?? locale.value.searchHere,
                          prefixIcon: commonLeadingWid(imgPath: Assets.iconsIcSearch, icon: Icons.search_outlined, size: 14).paddingAll(12),
                          filled: true,
                          fillColor: context.scaffoldBackgroundColor,
                          suffixIcon: Obx(
                            () => appCloseIconButton(
                              context,
                              onPressed: () {
                                handleCloseClick(context, getxBSSCont);
                              },
                              size: 11,
                            ).visible(getxBSSCont.isSearchText.value),
                          ),
                        ),
                      ).visible(!hideSearchBar),
                      32.height.visible(!hideSearchBar),
                      hasError
                          ? Obx(
                              () => NoDataWidget(
                                title: errorText ?? locale.value.somethingWentWrong,
                                retryText: locale.value.reload,
                                imageWidget: const ErrorStateWidget(),
                                onRetry: isLoading == true.obs ? null : onRetry,
                              ).paddingSymmetric(horizontal: 32),
                            )
                          : isEmpty
                              ? Obx(
                                  () => NoDataWidget(
                                    title: noDataTitle ?? locale.value.noDataFound,
                                    subTitle: noDataSubTitle,
                                    titleTextStyle: primaryTextStyle(),
                                    retryText: locale.value.reload,
                                    imageWidget: const EmptyStateWidget(),
                                    onRetry: isLoading == true.obs ? null : onRetry,
                                  ).paddingSymmetric(horizontal: 32),
                                )
                              : listWidget,
                      32.height,
                    ],
                  ).paddingSymmetric(horizontal: 30),
                  Positioned(
                    top: 22,
                    right: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: primaryTextStyle(size: 18),
                        ).paddingOnly(left: 30),
                        appCloseIconButton(
                          context,
                          onPressed: () {
                            handleCloseClick(context, getxBSSCont);
                            Get.back();
                          },
                          size: 11,
                        ).paddingOnly(right: 16),
                      ],
                    ),
                  ),
                  Obx(() => const LoaderWidget().center().visible(isLoading == null ? false : isLoading!.value)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void handleCloseClick(BuildContext context, BSScontroller getxBSSCont) {
    if (searchApiCall != null && getxBSSCont.isSearchText.value) {
      searchApiCall?.call("");
    }
    hideKeyboard(context);
    getxBSSCont.searchCont.clear();
    getxBSSCont.isSearchText(getxBSSCont.searchCont.text.trim().isNotEmpty);
  }
}

void serviceCommonBottomSheet(BuildContext context, {required Widget child, final Function(dynamic)? onSheetClose}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    builder: (context) => child,
  ).then((value) {
    onSheetClose?.call(value);
  });
}
