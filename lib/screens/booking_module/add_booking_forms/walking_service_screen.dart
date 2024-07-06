import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/bottom_selection_widget.dart';
import '../../../components/cached_image_widget.dart';
import '../../../components/chat_gpt_loder.dart';
import '../../../components/loader_widget.dart';
import '../../../components/service_app_button.dart';
import '../../../generated/assets.dart';
import '../services/service_navigation.dart';
import 'walking_service_controller.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../model/choose_pet_widget.dart';
import '../model/employe_model.dart';

class WalkingServiceScreen extends StatelessWidget {
  final bool isFromReschedule;
  WalkingServiceScreen({Key? key, this.isFromReschedule = false}) : super(key: key);
  final WalkingServiceController walkingServiceController = Get.put(WalkingServiceController());
  final GlobalKey<FormState> _walkingformKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return isFromReschedule
        ? Form(
            key: _walkingformKey,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dateTimeWidget(context),
                    const Spacer(),
                    AppButton(
                      width: Get.width,
                      text: locale.value.update,
                      textStyle: appButtonTextStyleWhite,
                      color: primaryColor,
                      onTap: () {
                        if (_walkingformKey.currentState!.validate()) {
                          _walkingformKey.currentState!.save();
                          hideKeyboard(context);
                          walkingServiceController.handleBookNowClick(isFromReschedule: isFromReschedule);
                        }
                      },
                    ),
                  ],
                ),
                Obx(() => const LoaderWidget().center().visible(walkingServiceController.isLoading.value))
              ],
            ),
          )
        : AppScaffold(
            appBarTitle: Hero(
              tag: currentSelectedService.value.name,
              child: Text(
                "${locale.value.book} ${getServiceNameByServiceElement(serviceSlug: currentSelectedService.value.slug)}",
                style: primaryTextStyle(size: 16, decoration: TextDecoration.none),
              ),
            ),
            body: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Form(
                    key: _walkingformKey,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.height,
                        ChooseYourPet(
                          onChanged: (selectedPet) {
                            walkingServiceController.bookWalkingReq.petId = selectedPet.id;
                          },
                        ),
                        32.height,
                        dateTimeWidget(context),
                        32.height,
                        Obx(() => durationWidget()),
                        32.height,
                        AppTextField(
                          title: locale.value.dropoffPickupAddress,
                          textStyle: primaryTextStyle(size: 12),
                          textFieldType: TextFieldType.MULTILINE,
                          minLines: 5,
                          controller: walkingServiceController.addressCont,
                          // focus: editUserProfileController.addressFocus,
                          decoration: inputDecoration(
                            context,
                            hintText: locale.value.writeHere,
                            fillColor: context.cardColor,
                            filled: true,
                          ),
                        ).paddingSymmetric(horizontal: 16),
                        24.height,
                        SizedBox(
                          height: 32,
                          child: Row(
                            children: [
                              Text(locale.value.walker, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
                              const Spacer(),
                              Obx(
                                () => Row(
                                  children: [
                                    Text(
                                      locale.value.showNearby,
                                      style: secondaryTextStyle(color: darkGrayGeneral),
                                    ),
                                    Transform.scale(
                                      scale: 0.65,
                                      child: Switch(
                                        activeTrackColor: switchActiveTrackColor,
                                        value: walkingServiceController.isShowNearBy.value,
                                        activeColor: switchActiveColor,
                                        inactiveTrackColor: switchColor.withOpacity(0.2),
                                        onChanged: (bool value) {
                                          walkingServiceController.isShowNearBy.value = !walkingServiceController.isShowNearBy.value;

                                          if (walkingServiceController.isShowNearBy.value) {
                                            walkingServiceController.handleCurrentLocationClick();
                                          } else {
                                            walkingServiceController.getWalker();
                                          }
                                        },
                                      ),
                                    ),
                                    8.width,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => AppTextField(
                            /*  title: locale.value.walker,*/
                            spacingBetweenTitleAndTextFormField: 0,
                            textStyle: primaryTextStyle(size: 12),
                            controller: walkingServiceController.walkerCont,
                            textFieldType: TextFieldType.OTHER,
                            readOnly: true,
                            onTap: () {
                              serviceCommonBottomSheet(context,
                                  child: Obx(
                                    () => BottomSelectionSheet(
                                      title: locale.value.chooseWalker,
                                      hintText: locale.value.searchForWalker,
                                      hasError: walkingServiceController.hasErrorFetchingWalker.value,
                                      isEmpty: !walkingServiceController.isLoading.value && walkingServiceController.walkerList.isEmpty,
                                      errorText: walkingServiceController.errorMessageWalker.value,
                                      isLoading: walkingServiceController.isLoading,
                                      noDataTitle: locale.value.walkerListIsEmpty,
                                      noDataSubTitle: locale.value.thereAreNoWalkers,
                                      searchApiCall: (p0) {
                                        walkingServiceController.getWalker(searchtext: p0);
                                      },
                                      onRetry: () {
                                        walkingServiceController.getWalker();
                                      },
                                      listWidget: Obx(
                                        () => walkerListWid(walkingServiceController.walkerList).expand(),
                                      ),
                                    ),
                                  ));
                            },
                            decoration: inputDecoration(
                              context,
                              hintText: locale.value.chooseWalker,
                              fillColor: context.cardColor,
                              filled: true,
                              prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                              prefixIcon: walkingServiceController.selectedWalker.value.profileImage.isEmpty && walkingServiceController.selectedWalker.value.id.isNegative
                                  ? null
                                  : CachedImageWidget(
                                      url: walkingServiceController.selectedWalker.value.profileImage.value,
                                      height: 35,
                                      width: 35,
                                      fit: BoxFit.cover,
                                      circle: true,
                                      usePlaceholderIfUrlEmpty: true,
                                    ).paddingOnly(left: 12, top: 8, bottom: 8, right: 12),
                              suffixIcon: walkingServiceController.selectedWalker.value.profileImage.isEmpty && walkingServiceController.selectedWalker.value.id.isNegative
                                  ? Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 24,
                                      color: darkGray.withOpacity(0.5),
                                    )
                                  : appCloseIconButton(
                                      context,
                                      onPressed: () {
                                        walkingServiceController.clearWalkerSelection();
                                      },
                                      size: 11,
                                    ),
                            ),
                          ).paddingSymmetric(horizontal: 16),
                        ),
                        32.height,
                        AppTextField(
                          title: locale.value.additionalInformation,
                          textStyle: primaryTextStyle(size: 12),
                          textFieldType: TextFieldType.MULTILINE,
                          isValidationRequired: false,
                          minLines: 5,
                          controller: walkingServiceController.additionalInfoCont,
                          // focus: editUserProfileController.addressFocus,
                          decoration: inputDecoration(context, hintText: locale.value.writeHere, fillColor: context.cardColor, filled: true),
                          enableChatGPT: appConfigs.value.enableChatGpt,
                          promptFieldInputDecorationChatGPT: inputDecoration(context, hintText: locale.value.writeHere, fillColor: context.scaffoldBackgroundColor, filled: true),
                          testWithoutKeyChatGPT: appConfigs.value.testWithoutKey,
                          loaderWidgetForChatGPT: const ChatGPTLoadingWidget(),
                        ).paddingSymmetric(horizontal: 16),
                      ],
                    ),
                  ),
                ).expand(),
                Obx(
                  () => AppButtonWithPricing(
                    price: totalAmount.toStringAsFixed(2).toDouble(),
                    tax: totalTax.toStringAsFixed(2).toDouble(),
                    items: getServiceNameByServiceElement(serviceSlug: currentSelectedService.value.slug),
                    serviceImg: currentSelectedService.value.serviceImage,
                    onTap: () {
                      if (_walkingformKey.currentState!.validate()) {
                        _walkingformKey.currentState!.save();
                        if (walkingServiceController.selectedDuration.value.id > 0 && walkingServiceController.bookWalkingReq.petId > 0) {
                          hideKeyboard(context);
                          walkingServiceController.handleBookNowClick();
                        } else if (walkingServiceController.selectedDuration.value.id <= 0) {
                          toast(locale.value.pleaseChooseDuration);
                        } else if (walkingServiceController.bookWalkingReq.petId <= 0) {
                          toast(locale.value.pleaseSelectPet);
                        }
                      }
                    },
                  ).paddingSymmetric(horizontal: 16).visible(walkingServiceController.showBookBtn.value),
                ),
              ],
            ),
          );
  }

  Widget dateTimeWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  title: locale.value.date,
                  textStyle: primaryTextStyle(size: 12),
                  controller: walkingServiceController.dateCont,
                  textFieldType: TextFieldType.NAME,
                  readOnly: true,
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2101));
                    if (selectedDate != null) {
                      walkingServiceController.bookWalkingReq.date = selectedDate.formatDateYYYYmmdd();
                      walkingServiceController.dateCont.text = selectedDate.formatDateDDMMYY();
                      log('walkingServiceController.BOOKBOARDINGREQ: ${walkingServiceController.bookWalkingReq.toJson()}');
                    } else {
                      log("Date is not selected");
                    }
                  },
                  decoration: inputDecoration(
                    context,
                    hintText: locale.value.selectDate,
                    fillColor: context.cardColor,
                    filled: true,
                    suffixIcon: Assets.navigationIcCalendarOutlined.iconImage(color: secondaryTextColor, fit: BoxFit.contain).paddingAll(14),
                  ),
                ),
              ],
            ).expand(),
            16.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  title: locale.value.time,
                  textStyle: primaryTextStyle(size: 12),
                  controller: walkingServiceController.timeCont,
                  textFieldType: TextFieldType.NAME,
                  readOnly: true,
                  onTap: () async {
                    if (walkingServiceController.dateCont.text.trim().isEmpty) {
                      toast(locale.value.pleaseSelectDateFirst);
                    } else {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.fromDateTime(walkingServiceController.bookWalkingReq.time.dateInHHmm24HourFormat), //TODO: Make Time Extension
                        context: context,
                      );
                      if (pickedTime != null) {
                        if ("${walkingServiceController.bookWalkingReq.date} ${pickedTime.formatTimeHHmm24Hour()}".isAfterCurrentDateTime) {
                          walkingServiceController.bookWalkingReq.time = pickedTime.formatTimeHHmm24Hour();
                          walkingServiceController.timeCont.text = pickedTime.formatTimeHHmmAMPM();
                        } else {
                          toast(locale.value.oopsItSeemsYouVe);
                        }
                      } else {
                        log("Time is not selected");
                      }
                    }
                  },
                  decoration: inputDecoration(
                    context,
                    hintText: locale.value.selectTime,
                    fillColor: context.cardColor,
                    filled: true,
                    suffixIcon: Assets.iconsIcTimeOutlined.iconImage(color: secondaryTextColor, fit: BoxFit.contain).paddingAll(14),
                  ),
                ),
              ],
            ).expand(),
          ],
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget durationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.value.duration, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
        8.height,
        Obx(() => SnapHelperWidget(
            future: walkingServiceController.duration.value,
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
              ).paddingSymmetric(horizontal: 32);
            },
            loadingWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${locale.value.loading}... ", style: secondaryTextStyle(size: 14, fontFamily: fontFamilyFontBold)),
              ],
            ),
            onSuccess: (durationList) {
              return durationList.isEmpty
                  ? NoDataWidget(
                      title: locale.value.durationListIsEmpty,
                      subTitle: locale.value.theDurationListIs,
                      titleTextStyle: primaryTextStyle(),
                    ).paddingSymmetric(horizontal: 32)
                  : HorizontalList(
                      itemCount: durationList.length,
                      spacing: 16,
                      runSpacing: 16,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        return Obx(
                          () => InkWell(
                            onTap: () {
                              walkingServiceController.selectedDuration(durationList[index]);
                              walkingServiceController.bookWalkingReq.duration = durationList[index].duration.toString();
                              currentSelectedService.value.serviceAmount = walkingServiceController.selectedDuration.value.price.toDouble();
                              walkingServiceController.bookWalkingReq.price = walkingServiceController.selectedDuration.value.price.toDouble();
                              walkingServiceController.showBookBtn(false);
                              walkingServiceController.showBookBtn(true);
                            },
                            borderRadius: radius(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: boxDecorationDefault(
                                color: walkingServiceController.selectedDuration.value == durationList[index]
                                    ? isDarkMode.value
                                        ? darkGrayGeneral2
                                        : lightPrimaryColor
                                    : context.cardColor,
                              ),
                              child: Text(
                                durationList[index].duration.toFormattedDuration(),
                                style: secondaryTextStyle(
                                  color: walkingServiceController.selectedDuration.value == durationList[index] ? primaryColor : null,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            })),
      ],
    );
  }

  Widget walkerListWid(List<EmployeeModel> list) {
    return ListView.separated(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SettingItemWidget(
          title: list[index].fullName,
          subTitle: walkingServiceController.isLoading.value
              ? "${locale.value.loading}... "
              : walkingServiceController.isShowNearBy.value
                  ? list[index].distance > 0
                      ? "${list[index].distance} ${locale.value.milesAway}"
                      : locale.value.walkerIsCurrentlyNot
                  : null,
          titleTextStyle: primaryTextStyle(size: 14),
          leading: CachedImageWidget(url: list[index].profileImage.value, height: 35, fit: BoxFit.cover, width: 35, circle: true),
          onTap: () {
            walkingServiceController.selectedWalker(list[index]);
            walkingServiceController.walkerCont.text = walkingServiceController.selectedWalker.value.fullName;
            walkingServiceController.bookWalkingReq.employeeId = walkingServiceController.selectedWalker.value.id;
            walkingServiceController.getWalker();
            Get.back();
          },
        );
      },
      separatorBuilder: (context, index) => commonDivider.paddingSymmetric(vertical: 6),
    );
  }
}
