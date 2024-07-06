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
import '../model/service_model.dart';
import '../services/service_navigation.dart';
import 'grooming_service_controller.dart';

class GroomingScreen extends StatelessWidget {
  final bool isFromReschedule;

  GroomingScreen({Key? key, this.isFromReschedule = false}) : super(key: key);
  final GroomingController groomingController = Get.put(GroomingController());
  final GlobalKey<FormState> _groomingformKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return isFromReschedule
        ? Form(
            key: _groomingformKey,
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
                        if (_groomingformKey.currentState!.validate()) {
                          _groomingformKey.currentState!.save();
                          hideKeyboard(context);
                          groomingController.handleBookNowClick(isFromReschedule: isFromReschedule);
                        }
                      },
                    ),
                  ],
                ),
                Obx(() => const LoaderWidget().center().visible(groomingController.isLoading.value))
              ],
            ),
          )
        : AppScaffold(
            appBartitleText: locale.value.grooming,
            appBarTitle: Hero(
              tag: currentSelectedService.value.name,
              child: Text(
                "${locale.value.book} ${getServiceNameByServiceElement(serviceSlug: currentSelectedService.value.slug)}",
                style: primaryTextStyle(size: 16, decoration: TextDecoration.none),
              ),
            ),
            isLoading: groomingController.isLoading,
            body: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Form(
                    key: _groomingformKey,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.height,
                        ChooseYourPet(
                          onChanged: (selectedPet) {
                            groomingController.bookGroomingReq.petId = selectedPet.id;
                          },
                        ),
                        32.height,
                        dateTimeWidget(context),
                        32.height,
                        Obx(
                          () => AppTextField(
                            title: locale.value.service,
                            textStyle: primaryTextStyle(size: 12),
                            controller: groomingController.serviceCont,
                            textFieldType: TextFieldType.OTHER,
                            readOnly: true,
                            onTap: () async {
                              serviceCommonBottomSheet(
                                context,
                                child: BottomSelectionSheet(
                                  title: locale.value.chooseService,
                                  hintText: locale.value.searchForService,
                                  hasError: groomingController.hasErrorFetchingService.value,
                                  isEmpty: !groomingController.isLoading.value && groomingController.serviceList.isEmpty,
                                  errorText: groomingController.errorMessageService.value,
                                  noDataTitle: locale.value.serviceListIsEmpty,
                                  noDataSubTitle: locale.value.thereAreNoServices,
                                  isLoading: groomingController.isLoading,
                                  searchApiCall: (p0) {
                                    groomingController.getService(searchtext: p0);
                                  },
                                  onRetry: () {
                                    groomingController.getService();
                                  },
                                  listWidget: Obx(
                                    () => grommingServiceListWid(groomingController.serviceList).expand(),
                                  ),
                                ),
                              );
                            },
                            decoration: inputDecoration(context,
                                hintText: locale.value.chooseService,
                                fillColor: context.cardColor,
                                filled: true,
                                prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                                prefixIcon: groomingController.selectedService.value.serviceImage.isEmpty && groomingController.selectedService.value.id.isNegative
                                    ? null
                                    : CachedImageWidget(
                                        url: groomingController.selectedService.value.serviceImage,
                                        height: 35,
                                        width: 35,
                                        firstName: groomingController.selectedService.value.name,
                                        fit: BoxFit.cover,
                                        circle: true,
                                        usePlaceholderIfUrlEmpty: true,
                                      ).paddingOnly(left: 12, top: 8, bottom: 8, right: 12),
                                suffixIcon: groomingController.selectedService.value.serviceImage.isNotEmpty && groomingController.selectedService.value.id.isNegative
                                    ? Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5))
                                    : Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5))),
                          ).paddingSymmetric(horizontal: 16).visible(!groomingController.isRefresh.value),
                        ),
                        32.height,
                        Obx(
                          () => Column(
                            children: [
                              AppTextField(
                                title: locale.value.groomer,
                                textStyle: primaryTextStyle(size: 12),
                                controller: groomingController.groomerCont,
                                textFieldType: TextFieldType.OTHER,
                                readOnly: true,
                                onTap: () async {
                                  if (groomingController.groomerList.length == 1 && groomingController.selectedService.value.createdBy == groomingController.groomerList.first.id) {
                                    //
                                  } else {
                                    if (groomingController.selectedService.value.id.isNegative) {
                                      toast(locale.value.pleaseSelectService);
                                      return;
                                    }
                                    serviceCommonBottomSheet(
                                      context,
                                      child: Obx(
                                        () => BottomSelectionSheet(
                                          title: locale.value.chooseGroomer,
                                          hintText: locale.value.searchForGroomer,
                                          hasError: groomingController.hasErrorFetchingGroomer.value,
                                          isEmpty: !groomingController.isLoading.value && groomingController.groomerList.isEmpty,
                                          errorText: groomingController.errorMessageGroomer.value,
                                          noDataTitle: locale.value.groomerListIsEmpty,
                                          noDataSubTitle: locale.value.thereAreNoGroomers,
                                          isLoading: groomingController.isLoading,
                                          searchApiCall: (p0) {
                                            groomingController.getGroomer(searchtext: p0);
                                          },
                                          onRetry: () {
                                            groomingController.getGroomer();
                                          },
                                          listWidget: Obx(
                                            () => groomerListWid(
                                              groomingController.groomerList,
                                            ).expand(),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                decoration: inputDecoration(
                                  context,
                                  hintText: locale.value.chooseGroomer,
                                  fillColor: context.cardColor,
                                  filled: true,
                                  prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                                  prefixIcon: groomingController.selectedGroomer.value.profileImage.isEmpty && groomingController.selectedGroomer.value.id.isNegative
                                      ? null
                                      : CachedImageWidget(
                                          url: groomingController.selectedGroomer.value.profileImage.value,
                                          height: 35,
                                          width: 35,
                                          fit: BoxFit.cover,
                                          circle: true,
                                        ).paddingOnly(left: 12, top: 8, bottom: 8, right: 12),
                                  suffixIcon: !groomingController.selectedService.value.createdBy.isNegative
                                      ? const Offstage()
                                      : groomingController.selectedGroomer.value.profileImage.isEmpty && groomingController.selectedGroomer.value.id.isNegative
                                          ? Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              size: 24,
                                              color: darkGray.withOpacity(0.5),
                                            )
                                          : appCloseIconButton(
                                              context,
                                              onPressed: () {
                                                groomingController.clearGroomerSelection();
                                              },
                                              size: 11,
                                            ),
                                ),
                              ).paddingSymmetric(horizontal: 16).visible(!groomingController.isRefresh.value),
                              Text(
                                locale.value.noteYourSelectedService,
                                style: secondaryTextStyle(size: 10),
                              ).paddingOnly(left: 16, right: 16, top: 6).visible(!groomingController.selectedService.value.createdBy.isNegative),
                            ],
                          ),
                        ),
                        32.height,
                        AppTextField(
                          title: locale.value.additionalInformation,
                          textStyle: primaryTextStyle(size: 12),
                          textFieldType: TextFieldType.MULTILINE,
                          isValidationRequired: false,
                          minLines: 5,
                          controller: groomingController.additionalInfoCont,
                          // focus: editUserProfileController.addressFocus,
                          decoration: inputDecoration(context, hintText: locale.value.writeHere, fillColor: context.cardColor, filled: true),
                          enableChatGPT: appConfigs.value.enableChatGpt,
                          promptFieldInputDecorationChatGPT: inputDecoration(context, hintText: locale.value.writeHere, fillColor: context.scaffoldBackgroundColor, filled: true),
                          testWithoutKeyChatGPT: appConfigs.value.testWithoutKey,
                          loaderWidgetForChatGPT: const ChatGPTLoadingWidget(),
                        ).paddingSymmetric(horizontal: 16),
                        96.height,
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
                      if (_groomingformKey.currentState!.validate()) {
                        _groomingformKey.currentState!.save();
                        if (groomingController.bookGroomingReq.petId > 0) {
                          hideKeyboard(context);
                          groomingController.handleBookNowClick();
                        } else {
                          toast(locale.value.pleaseSelectPet);
                        }
                      }
                    },
                  ).paddingSymmetric(horizontal: 16).visible(groomingController.showBookBtn.value),
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
                  controller: groomingController.dateCont,
                  textFieldType: TextFieldType.NAME,
                  readOnly: true,
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2101));

                    if (selectedDate != null) {
                      groomingController.bookGroomingReq.date = selectedDate.formatDateYYYYmmdd();
                      groomingController.dateCont.text = selectedDate.formatDateDDMMYY();
                      log('REQ: ${groomingController.bookGroomingReq.toJson()}');
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
                  controller: groomingController.timeCont,
                  textFieldType: TextFieldType.NAME,
                  readOnly: true,
                  onTap: () async {
                    if (groomingController.dateCont.text.trim().isEmpty) {
                      toast(locale.value.pleaseSelectDateFirst);
                    } else {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.fromDateTime(groomingController.bookGroomingReq.time.dateInHHmm24HourFormat), //TODO: Make Time Extension
                        context: context,
                      );

                      if (pickedTime != null) {
                        if ("${groomingController.bookGroomingReq.date} ${pickedTime.formatTimeHHmm24Hour()}".isAfterCurrentDateTime) {
                          groomingController.bookGroomingReq.time = pickedTime.formatTimeHHmm24Hour();
                          groomingController.timeCont.text = pickedTime.formatTimeHHmmAMPM();
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

  Widget grommingServiceListWid(List<ServiceModel> list) {
    return ListView.separated(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SettingItemWidget(
          title: list[index].name,
          titleTextStyle: primaryTextStyle(size: 14),
          leading: CachedImageWidget(url: list[index].serviceImage, height: 35, fit: BoxFit.cover, width: 35, circle: true),
          onTap: () {
            groomingController.selectedService(list[index]);
            groomingController.serviceCont.text = groomingController.selectedService.value.name;
            groomingController.bookGroomingReq.price = groomingController.serviceList[index].defaultPrice;
            currentSelectedService.value.serviceAmount = groomingController.selectedService.value.defaultPrice.toDouble();
            groomingController.groomerCont.clear();
            groomingController.selectedGroomer = EmployeeModel(profileImage: "".obs).obs;
            groomingController.getGroomer();
            groomingController.showBookBtn(false);
            groomingController.showBookBtn(true);
            groomingController.getService();
            Get.back();
          },
        );
      },
      separatorBuilder: (context, index) => commonDivider.paddingSymmetric(vertical: 6),
    );
  }

  Widget groomerListWid(List<EmployeeModel> list) {
    return ListView.separated(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SettingItemWidget(
          title: list[index].fullName,
          titleTextStyle: primaryTextStyle(size: 14),
          leading: CachedImageWidget(url: list[index].profileImage.value, height: 35, fit: BoxFit.cover, width: 35, circle: true),
          onTap: () {
            groomingController.selectedGroomer(list[index]);
            groomingController.groomerCont.text = groomingController.selectedGroomer.value.fullName;
            groomingController.bookGroomingReq.employeeId = groomingController.selectedGroomer.value.id;
            groomingController.reloadWidget();
            groomingController.getGroomer();
            Get.back();
          },
        );
      },
      separatorBuilder: (context, index) => commonDivider.paddingSymmetric(vertical: 6),
    );
  }
}
