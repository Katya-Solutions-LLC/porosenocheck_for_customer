import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/bottom_selection_widget.dart';
import '../../../components/cached_image_widget.dart';
import '../../../components/chat_gpt_loder.dart';
import '../../../components/loader_widget.dart';
import '../../../components/service_app_button.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../model/choose_pet_widget.dart';
import '../model/employe_model.dart';
import '../services/service_navigation.dart';
import 'daycare_service_controller.dart';

class DayCareScreen extends StatelessWidget {
  final bool isFromReschedule;

  DayCareScreen({Key? key, this.isFromReschedule = false}) : super(key: key);
  final DayCareServiceController dayCareServiceController = Get.put(DayCareServiceController());
  final GlobalKey<FormState> _daycareformKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return isFromReschedule
        ? Form(
            key: _daycareformKey,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dateTimeWidget(context),
                    32.height,
                    dropOFFnPickTime(context),
                    const Spacer(),
                    AppButton(
                      width: Get.width,
                      text: locale.value.update,
                      textStyle: appButtonTextStyleWhite,
                      color: primaryColor,
                      onTap: () {
                        if (_daycareformKey.currentState!.validate()) {
                          _daycareformKey.currentState!.save();
                          hideKeyboard(context);
                          dayCareServiceController.handleBookNowClick(isFromReschedule: isFromReschedule);
                        }
                      },
                    ),
                  ],
                ),
                Obx(() => const LoaderWidget().center().visible(dayCareServiceController.isLoading.value))
              ],
            ),
          )
        : AppScaffold(
            appBartitleText: locale.value.daycare,
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
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Form(
                    key: _daycareformKey,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.height,
                        ChooseYourPet(
                          onChanged: (selectedPet) {
                            dayCareServiceController.bookDayCareReq.petId = selectedPet.id;
                          },
                        ),
                        32.height,
                        dateTimeWidget(context),
                        32.height,
                        dropOFFnPickTime(context),
                        32.height,
                        Obx(
                          () => AppTextField(
                            title: locale.value.daycareTaker,
                            textStyle: primaryTextStyle(size: 12),
                            controller: dayCareServiceController.daycareTakerCont,
                            textFieldType: TextFieldType.NAME,
                            readOnly: true,
                            onTap: () {
                              serviceCommonBottomSheet(context,
                                  child: Obx(
                                    () => BottomSelectionSheet(
                                      title: locale.value.chooseDaycareTaker,
                                      hintText: locale.value.searchForDaycareTaker,
                                      hasError: dayCareServiceController.hasErrorFetchingDayCareTaker.value,
                                      isEmpty: !dayCareServiceController.isLoading.value && dayCareServiceController.dayCareTakerList.isEmpty,
                                      errorText: dayCareServiceController.errorMessageDayCareTaker.value,
                                      isLoading: dayCareServiceController.isLoading,
                                      noDataTitle: locale.value.daycareTakerListIsEmpty,
                                      noDataSubTitle: locale.value.thereAreNoDaycare,
                                      searchApiCall: (p0) {
                                        dayCareServiceController.getDayCareTakers(searchtext: p0);
                                      },
                                      onRetry: () {
                                        dayCareServiceController.getDayCareTakers();
                                      },
                                      listWidget: Obx(
                                        () => daycareListWid(dayCareServiceController.dayCareTakerList).expand(),
                                      ),
                                    ),
                                  ));
                            },
                            decoration: inputDecoration(
                              context,
                              hintText: locale.value.chooseDaycareTaker,
                              fillColor: context.cardColor,
                              filled: true,
                              prefixIcon: dayCareServiceController.selectedDayCareTaker.value.profileImage.isEmpty && dayCareServiceController.selectedDayCareTaker.value.id.isNegative
                                  ? null
                                  : CachedImageWidget(
                                      url: dayCareServiceController.selectedDayCareTaker.value.profileImage.value,
                                      height: 35,
                                      width: 35,
                                      fit: BoxFit.cover,
                                      circle: true,
                                    ).paddingOnly(left: 12, top: 8, bottom: 8, right: 12),
                              suffixIcon: dayCareServiceController.selectedDayCareTaker.value.profileImage.isEmpty && dayCareServiceController.selectedDayCareTaker.value.id.isNegative
                                  ? Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 24,
                                      color: darkGray.withOpacity(0.5),
                                    )
                                  : appCloseIconButton(
                                      context,
                                      onPressed: () {
                                        dayCareServiceController.clearDaycareTakerSelection();
                                      },
                                      size: 11,
                                    ),
                            ),
                          ).paddingSymmetric(horizontal: 16),
                        ),
                        32.height,
                        foodWidget(context),
                        32.height,
                        activityWidget(context),
                        32.height,
                        AppTextField(
                          title: locale.value.address,
                          textStyle: primaryTextStyle(size: 12),
                          textFieldType: TextFieldType.MULTILINE,
                          minLines: 5,
                          controller: dayCareServiceController.addressCont,
                          // focus: editUserProfileController.addressFocus,
                          decoration: inputDecoration(context, hintText: "${locale.value.eG} 123, ${locale.value.mainStreet}", fillColor: context.cardColor, filled: true),
                        ).paddingSymmetric(horizontal: 16),
                        32.height,
                        AppTextField(
                          title: locale.value.additionalInformation,
                          textStyle: primaryTextStyle(size: 12),
                          textFieldType: TextFieldType.MULTILINE,
                          isValidationRequired: false,
                          minLines: 5,
                          controller: dayCareServiceController.additionalInfoCont,
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
                      if (_daycareformKey.currentState!.validate()) {
                        _daycareformKey.currentState!.save();
                        if (dayCareServiceController.bookDayCareReq.petId > 0) {
                          hideKeyboard(context);
                          dayCareServiceController.handleBookNowClick();
                        } else {
                          toast(locale.value.pleaseSelectPet);
                        }
                      }
                    },
                  ).paddingSymmetric(horizontal: 16).visible(!dayCareServiceController.isRefresh.value),
                ),
              ],
            ),
          );
  }

  Widget daycareListWid(List<EmployeeModel> list) {
    return ListView.separated(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SettingItemWidget(
          title: list[index].fullName,
          titleTextStyle: primaryTextStyle(size: 14),
          leading: CachedImageWidget(url: list[index].profileImage.value, height: 35, fit: BoxFit.cover, width: 35, circle: true),
          onTap: () {
            dayCareServiceController.selectedDayCareTaker(list[index]);
            dayCareServiceController.daycareTakerCont.text = dayCareServiceController.selectedDayCareTaker.value.fullName;
            dayCareServiceController.bookDayCareReq.employeeId = dayCareServiceController.selectedDayCareTaker.value.id;
            dayCareServiceController.getDayCareTakers();
            Get.back();
          },
        );
      },
      separatorBuilder: (context, index) => commonDivider.paddingSymmetric(vertical: 6),
    );
  }

  Widget dateTimeWidget(BuildContext context) {
    return AppTextField(
      title: locale.value.date,
      textStyle: primaryTextStyle(size: 12),
      controller: dayCareServiceController.dateCont,
      textFieldType: TextFieldType.NAME,
      readOnly: true,
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: dayCareServiceController.bookDayCareReq.date.dateInyyyyMMddHHmmFormat.isAfter(DateTime.now()) ? dayCareServiceController.bookDayCareReq.date.dateInyyyyMMddHHmmFormat : DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );

        if (selectedDate != null) {
          dayCareServiceController.bookDayCareReq.date = selectedDate.formatDateYYYYmmdd();
          dayCareServiceController.dateCont.text = selectedDate.formatDateDDMMYY();
          log('BOOKDAYCAREREQ: ${dayCareServiceController.bookDayCareReq.toJson()}');
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
    ).paddingSymmetric(horizontal: 16);
  }

  Widget dropOFFnPickTime(BuildContext context) {
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
                  title: locale.value.arrivalTime,
                  textStyle: primaryTextStyle(size: 12),
                  controller: dayCareServiceController.dropOffTimeCont,
                  textFieldType: TextFieldType.NAME,
                  readOnly: true,
                  onTap: () async {
                    if (dayCareServiceController.dateCont.text.trim().isEmpty) {
                      toast(locale.value.pleaseSelectDropOff);
                    } else {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.fromDateTime(dayCareServiceController.bookDayCareReq.dropOfftime.dateInHHmm24HourFormat), //TODO: Make Time Extension
                        context: context,
                      );

                      if (pickedTime != null) {
                        if ("${dayCareServiceController.bookDayCareReq.date} ${pickedTime.formatTimeHHmm24Hour()}".isAfterCurrentDateTime) {
                          dayCareServiceController.bookDayCareReq.dropOfftime = pickedTime.formatTimeHHmm24Hour();
                          dayCareServiceController.dropOffTimeCont.text = pickedTime.formatTimeHHmmAMPM();
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
            16.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  title: locale.value.leaveTime,
                  textStyle: primaryTextStyle(size: 12),
                  controller: dayCareServiceController.pickUpTimeCont,
                  textFieldType: TextFieldType.NAME,
                  readOnly: true,
                  onTap: () async {
                    if (dayCareServiceController.dateCont.text.trim().isEmpty) {
                      toast(locale.value.pleaseSelectDateFirst);
                    } else if (dayCareServiceController.dropOffTimeCont.text.trim().isEmpty) {
                      toast(locale.value.pleaseSelectDropOffTime);
                    } else {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.fromDateTime(dayCareServiceController.bookDayCareReq.pickUptime.dateInHHmm24HourFormat), //TODO: Make Time Extension
                        context: context,
                      );

                      if (pickedTime != null) {
                        if ("${dayCareServiceController.bookDayCareReq.date} ${pickedTime.formatTimeHHmm24Hour()}".isAfterCurrentDateTime) {
                          if (pickedTime.formatTimeHHmm24Hour().dateInHHmm24HourFormat.isAfter(dayCareServiceController.bookDayCareReq.dropOfftime.dateInHHmm24HourFormat)) {
                            dayCareServiceController.bookDayCareReq.pickUptime = pickedTime.formatTimeHHmm24Hour();
                            dayCareServiceController.pickUpTimeCont.text = pickedTime.formatTimeHHmmAMPM();
                          } else {
                            toast(locale.value.pleaseMakeSureTo);
                          }
                        } else {
                          toast(locale.value.oopsItSeemsYouVePickupTime);
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

  Widget foodWidget(BuildContext context) {
    return AppTextField(
      title: locale.value.favoriteFood,
      textStyle: primaryTextStyle(size: 12),
      controller: dayCareServiceController.favFoodCont,
      textFieldType: TextFieldType.OTHER,
      decoration: inputDecoration(
        context,
        hintText: '${locale.value.eG}  ${locale.value.fish}',
        fillColor: context.cardColor,
        filled: true,
        suffixIcon: Assets.imagesFavFood.iconImage(color: secondaryTextColor, fit: BoxFit.contain).paddingAll(14),
      ),
    ).paddingSymmetric(horizontal: 16);
  }

  Widget activityWidget(BuildContext context) {
    return AppTextField(
      title: locale.value.favoriteActivity,
      textStyle: primaryTextStyle(size: 12),
      controller: dayCareServiceController.favActCont,
      textFieldType: TextFieldType.OTHER,
      decoration: inputDecoration(
        context,
        hintText: '${locale.value.eG}  ${locale.value.playWithBall}',
        fillColor: context.cardColor,
        filled: true,
        suffixIcon: Assets.imagesFavActivity.iconImage(color: secondaryTextColor, fit: BoxFit.contain).paddingAll(14),
      ),
    ).paddingSymmetric(horizontal: 16);
  }
}
