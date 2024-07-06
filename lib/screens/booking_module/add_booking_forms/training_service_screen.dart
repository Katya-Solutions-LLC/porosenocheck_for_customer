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
import '../services/service_navigation.dart';
import 'training_service_controller.dart';
import '../../../utils/app_common.dart';

import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../model/choose_pet_widget.dart';
import '../model/employe_model.dart';
import '../model/training_model.dart';

class TrainingServiceScreen extends StatelessWidget {
  final bool isFromReschedule;
  TrainingServiceScreen({Key? key, this.isFromReschedule = false}) : super(key: key);
  final TrainingController trainingController = Get.put(TrainingController());
  final GlobalKey<FormState> _trainingformKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return isFromReschedule
        ? Form(
            key: _trainingformKey,
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
                        if (_trainingformKey.currentState!.validate()) {
                          _trainingformKey.currentState!.save();
                          hideKeyboard(context);
                          trainingController.handleBookNowClick(isFromReschedule: isFromReschedule);
                        }
                      },
                    ),
                  ],
                ),
                Obx(() => const LoaderWidget().center().visible(trainingController.isLoading.value))
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
                    key: _trainingformKey,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.height,
                        ChooseYourPet(
                          onChanged: (selectedPet) {
                            trainingController.bookTrainingReq.petId = selectedPet.id;
                          },
                        ),
                        32.height,
                        dateTimeWidget(context),
                        32.height,
                        Obx(() => durationWidget()),
                        32.height,
                        AppTextField(
                          title: locale.value.training,
                          textStyle: primaryTextStyle(size: 12),
                          controller: trainingController.trainingCont,
                          textFieldType: TextFieldType.NAME,
                          readOnly: true,
                          onTap: () {
                            trainingController.trainingFilterList.clear();
                            trainingController.searchCont.clear();
                            serviceCommonBottomSheet(context,
                                child: BottomSelectionSheet(
                                  title: locale.value.chooseTraining,
                                  hintText: locale.value.searchForTraining,
                                  hasError: trainingController.hasErrorFetchingTraining.value,
                                  isEmpty: !trainingController.isLoading.value && trainingController.isShowFullList ? trainingController.trainingList.isEmpty : trainingController.trainingFilterList.isEmpty,
                                  errorText: trainingController.errorMessageTraining.value,
                                  isLoading: trainingController.isLoading,
                                  noDataTitle: locale.value.trainingListIsEmpty,
                                  noDataSubTitle: locale.value.thereAreNoTraining,
                                  searchApiCall: (p0) {
                                    trainingController.getTraining(searchtext: p0);
                                  },
                                  onRetry: () {
                                    trainingController.getTraining();
                                  },
                                  listWidget: Obx(
                                    () => trainingListWid(
                                      trainingController.trainingList,
                                    ).expand(),
                                  ),
                                ));
                          },
                          decoration: inputDecoration(
                            context,
                            hintText: locale.value.chooseTraining,
                            fillColor: context.cardColor,
                            filled: true,
                            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
                          ),
                        ).paddingSymmetric(horizontal: 16),
                        32.height,
                        Obx(
                          () => AppTextField(
                            title: locale.value.trainer,
                            textStyle: primaryTextStyle(size: 12),
                            controller: trainingController.trainerCont,
                            textFieldType: TextFieldType.OTHER,
                            readOnly: true,
                            onTap: () {
                              trainingController.trainerFilterList.clear();
                              trainingController.searchCont.clear();
                              serviceCommonBottomSheet(
                                context,
                                child: Obx(
                                  () => BottomSelectionSheet(
                                    title: locale.value.chooseTrainer,
                                    hintText: locale.value.searchForTrainer,
                                    hasError: trainingController.hasErrorFetchingTrainer.value,
                                    isEmpty: !trainingController.isLoading.value && trainingController.trainerList.isEmpty,
                                    errorText: trainingController.errorMessageTrainer.value,
                                    isLoading: trainingController.isLoading,
                                    noDataTitle: locale.value.trainerListIsEmpty,
                                    noDataSubTitle: locale.value.thereAreNoTrainers,
                                    searchApiCall: (p0) {
                                      trainingController.getTraining(searchtext: p0);
                                    },
                                    onRetry: () {
                                      trainingController.getTrainer();
                                    },
                                    listWidget: Obx(
                                      () => trainerListWid(
                                        trainingController.trainerList,
                                      ).expand(),
                                    ),
                                  ),
                                ),
                              );
                            },
                            decoration: inputDecoration(
                              context,
                              hintText: locale.value.chooseTrainer,
                              fillColor: context.cardColor,
                              filled: true,
                              prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                              prefixIcon: trainingController.selectedTrainer.value.profileImage.isEmpty && trainingController.selectedTrainer.value.id.isNegative
                                  ? null
                                  : CachedImageWidget(
                                      url: trainingController.selectedTrainer.value.profileImage.value,
                                      height: 35,
                                      width: 35,
                                      fit: BoxFit.cover,
                                      circle: true,
                                      usePlaceholderIfUrlEmpty: true,
                                    ).paddingOnly(left: 12, top: 8, bottom: 8, right: 12),
                              suffixIcon: trainingController.selectedTrainer.value.profileImage.isEmpty && trainingController.selectedTrainer.value.id.isNegative
                                  ? Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 24,
                                      color: darkGray.withOpacity(0.5),
                                    )
                                  : appCloseIconButton(
                                      context,
                                      onPressed: () {
                                        trainingController.clearTrainerSelection();
                                      },
                                      size: 11,
                                    ),
                            ),
                          ).paddingSymmetric(horizontal: 16).visible(!trainingController.isRefresh.value),
                        ),
                        32.height,
                        AppTextField(
                          title: locale.value.additionalInformation,
                          textStyle: primaryTextStyle(size: 12),
                          textFieldType: TextFieldType.MULTILINE,
                          isValidationRequired: false,
                          minLines: 5,
                          controller: trainingController.additionalInfoCont,
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
                      if (_trainingformKey.currentState!.validate()) {
                        _trainingformKey.currentState!.save();
                        if (trainingController.bookTrainingReq.petId > 0) {
                          hideKeyboard(context);
                          trainingController.handleBookNowClick();
                        } else if (trainingController.selectedDuration.value.id <= 0) {
                          toast(locale.value.pleaseChooseDuration);
                        } else {
                          toast(locale.value.pleaseSelectPet);
                        }
                      }
                    },
                  ).paddingSymmetric(horizontal: 16).visible(trainingController.showBookBtn.value),
                ),
              ],
            ),
          );
  }

  Widget trainingListWid(List<TrainingModel> list) {
    return ListView.separated(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SettingItemWidget(
          title: list[index].name,
          titleTextStyle: primaryTextStyle(size: 14),
          onTap: () {
            trainingController.selectedTraining(list[index]);
            trainingController.trainingCont.text = trainingController.selectedTraining.value.name;
            Get.back();
          },
        );
      },
      separatorBuilder: (context, index) => commonDivider.paddingSymmetric(vertical: 6),
    );
  }

  Widget trainerListWid(List<EmployeeModel> list) {
    return ListView.separated(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SettingItemWidget(
          title: list[index].fullName,
          titleTextStyle: primaryTextStyle(size: 14),
          leading: CachedImageWidget(url: list[index].profileImage.value, height: 35, fit: BoxFit.cover, width: 35, circle: true),
          onTap: () {
            trainingController.selectedTrainer(list[index]);
            trainingController.trainerCont.text = trainingController.selectedTrainer.value.fullName;
            trainingController.isRefresh(true);
            trainingController.isRefresh(false);
            trainingController.getTrainer();
            Get.back();
          },
        );
      },
      separatorBuilder: (context, index) => commonDivider.paddingSymmetric(vertical: 6),
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
                  controller: trainingController.dateCont,
                  textFieldType: TextFieldType.NAME,
                  readOnly: true,
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2101));

                    if (selectedDate != null) {
                      trainingController.bookTrainingReq.date = selectedDate.formatDateYYYYmmdd();
                      trainingController.dateCont.text = selectedDate.formatDateDDMMYY();
                      log('trainingController.BOOKBOARDINGREQ: ${trainingController.bookTrainingReq.toJson()}');
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
                  controller: trainingController.timeCont,
                  textFieldType: TextFieldType.NAME,
                  readOnly: true,
                  onTap: () async {
                    if (trainingController.dateCont.text.trim().isEmpty) {
                      toast(locale.value.pleaseSelectDateFirst);
                    } else {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.fromDateTime(trainingController.bookTrainingReq.time.dateInHHmm24HourFormat), //TODO: Make Time Extension
                        context: context,
                      );

                      if (pickedTime != null) {
                        if ("${trainingController.bookTrainingReq.date} ${pickedTime.formatTimeHHmm24Hour()}".isAfterCurrentDateTime) {
                          trainingController.bookTrainingReq.time = pickedTime.formatTimeHHmm24Hour();
                          trainingController.timeCont.text = pickedTime.formatTimeHHmmAMPM();
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
        Obx(
          () => SnapHelperWidget(
            future: trainingController.duration.value,
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
                              trainingController.selectedDuration(durationList[index]);
                              trainingController.bookTrainingReq.duration = durationList[index].duration.toString();
                              currentSelectedService.value.serviceAmount = trainingController.selectedDuration.value.price.toDouble();
                              trainingController.bookTrainingReq.price = trainingController.selectedDuration.value.price.toDouble();
                              trainingController.showBookBtn(false);
                              trainingController.showBookBtn(true);
                            },
                            borderRadius: radius(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: boxDecorationDefault(
                                color: trainingController.selectedDuration.value == durationList[index]
                                    ? isDarkMode.value
                                        ? darkGrayGeneral2
                                        : lightPrimaryColor
                                    : context.cardColor,
                              ),
                              child: Text(
                                durationList[index].duration.toFormattedDuration(),
                                style: secondaryTextStyle(
                                  color: trainingController.selectedDuration.value == durationList[index] ? primaryColor : null,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ],
    );
  }
}
