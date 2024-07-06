import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/booking_module/booking_detail/booking_detail_screen_shimmer.dart';
import 'package:porosenocheck/screens/booking_module/payment_screen.dart';
import 'package:porosenocheck/utils/app_common.dart';
import 'package:porosenocheck/utils/empty_error_state_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/cached_image_widget.dart';
import '../../../components/chat_gpt_loder.dart';
import '../../../components/common_file_placeholders.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../pet/model/pet_note_model.dart';
import '../../pet/my_pets_controller.dart';
import '../../pet/profile/pet_profile_screen.dart';
import '../../pet_sitter/employee_detail_screen.dart';
import '../payment_controller.dart';
import '../services/service_navigation.dart';
import 'booking_detail_controller.dart';
import 'rescheduling_component.dart';

class BookingDetailScreen extends StatelessWidget {
  BookingDetailScreen({Key? key}) : super(key: key);
  final BookingDetailsController bookingController = Get.put(BookingDetailsController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: Hero(
        tag: '#${bookingController.bookingDetail.value.id}',
        child: Text(
          '#${bookingController.bookingDetail.value.id} - ${getServiceNameByServiceElement(serviceSlug: bookingController.bookingDetail.value.service.slug)}',
          style: primaryTextStyle(size: 16, decoration: TextDecoration.none),
        ),
      ),
      isLoading: bookingController.isLoading,
      body: RefreshIndicator(
        onRefresh: () async {
          return bookingController.init(showLoader: false);
        },
        child: Obx(
          () => SnapHelperWidget(
            future: bookingController.getBookingDetails.value,
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.value.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  bookingController.init();
                },
              ).paddingSymmetric(horizontal: 16);
            },
            loadingWidget: const BookingDetailScreenShimmer().paddingTop(16),
            onSuccess: (bookingDetailRes) {
              return AnimatedScrollView(
                listAnimationType: ListAnimationType.None,
                padding: const EdgeInsets.only(bottom: 80),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Obx(
                    () => bookingController.bookingDetail.value.service.id.isNegative
                        ? NoDataWidget(
                            title: locale.value.noBookingDetailsFound,
                            imageWidget: const EmptyStateWidget(),
                            subTitle: "${locale.value.thereAreCurrentlyNoDetails} \n${locale.value.bookingId} ${bookingController.bookingDetail.value.id}. ${locale.value.tryReloadOrCheckingLater}.",
                            retryText: locale.value.reload,
                            onRetry: () {
                              bookingController.init();
                            },
                          ).paddingSymmetric(horizontal: 32).paddingTop(Get.height * 0.20)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              16.height,
                              bookingInfoWidget(context),
                              Obx(() => bookingController.bookingDetail.value.petDetails != null ? petInfoWidget(context) : const Offstage()),
                              employeeInfoWidget(context),
                              paymentDetails(context),
                              Obx(() => bookingController.bookingDetail.value.petDetails != null && bookingController.bookingDetail.value.petDetails!.petNotes.isNotEmpty ? petNotes(context) : const Offstage()),
                              serviceInfoWidget(context).visible(bookingController.bookingDetail.value.service.slug.contains(ServicesKeyConst.training)),
                              additionalInfoWidget(context).visible(bookingController.bookingDetail.value.note.isNotEmpty),
                              Obx(() => medicalReportWidget().paddingSymmetric(horizontal: 16).visible(bookingController.bookingDetail.value.medicalReport.isNotEmpty)),
                              Obx(() => additionalFacilityWidget(context).visible(bookingController.facilities.isNotEmpty)),
                              Obx(() => payNowBtn(context)).visible(
                                (bookingController.bookingDetail.value.payment.paymentStatus.toLowerCase().contains(PaymentStatus.pending) || bookingController.bookingDetail.value.payment.paymentStatus.toLowerCase().contains(PaymentStatus.failed)) &&
                                    bookingController.bookingDetail.value.status.toLowerCase().contains(StatusConst.completed.toLowerCase()),
                              ),
                              Obx(
                                () => zoomVideoCallBtn(context).visible(
                                  bookingController.bookingDetail.value.joinVideoLink.isNotEmpty &&
                                      bookingController.bookingDetail.value.startVideoLink.isNotEmpty &&
                                      bookingController.bookingDetail.value.status.toLowerCase().contains(StatusConst.confirmed.toLowerCase()),
                                ),
                              ),
                              Obx(() => reviewPart(context).visible(!bookingController.isLoading.value && bookingController.bookingDetail.value.status.toLowerCase().contains(StatusConst.completed.toLowerCase()))),
                            ],
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget petNotes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(locale.value.petNotes, style: primaryTextStyle()),
            SizedBox(
              height: 23,
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(lightPrimaryColor2), padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
                onPressed: () {
                  myPetsScreenController.selectedPetProfile(bookingController.bookingDetail.value.petDetails!);
                  Get.to(() => PetProfileScreen());
                },
                child: Text(locale.value.seePetProfile, style: secondaryTextStyle(color: primaryColor)).paddingSymmetric(horizontal: 8, vertical: 2),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
        8.height,
        Obx(
          () => AnimatedListView(
            shrinkWrap: true,
            itemCount: bookingController.bookingDetail.value.petDetails!.petNotes.reversed.take(2).length,
            listAnimationType: ListAnimationType.FadeIn,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext contex, index) {
              NotePetModel notePetModel = bookingController.bookingDetail.value.petDetails!.petNotes.reversed.toList()[index];
              return GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: boxDecorationDefault(color: context.cardColor),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CachedImageWidget(
                                    url: notePetModel.createdbyUser.profileImage,
                                    height: 22,
                                    width: 22,
                                    circle: true,
                                    radius: 22,
                                    fit: BoxFit.cover,
                                  ),
                                  12.width,
                                  Text(notePetModel.createdbyUser.userName, style: secondaryTextStyle()),
                                ],
                              ),
                            ],
                          ).paddingBottom(16),
                          Text(notePetModel.title, textAlign: TextAlign.left, style: primaryTextStyle()),
                          8.height,
                          Text(notePetModel.description, textAlign: TextAlign.left, style: secondaryTextStyle()),
                        ],
                      ).paddingAll(16).expand(),
                    ],
                  ),
                ).paddingTop(index == 0 ? 0 : 12),
              );
            },
          ).paddingSymmetric(horizontal: 16),
        )
      ],
    );
  }

  Widget bookingInfoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(locale.value.bookingInformation, style: primaryTextStyle()),
            SizedBox(
              height: 23,
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(lightPrimaryColor2), padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
                onPressed: () {
                  handleRescheduleClick(context: context, isLoading: bookingController.isLoading, bookingDetail: bookingController.bookingDetail);
                },
                child: Text(locale.value.reschedule, style: secondaryTextStyle(color: primaryColor)).paddingSymmetric(horizontal: 8, vertical: 2),
              ),
            ).visible(bookingController.bookingDetail.value.status.contains(BookingStatusConst.PENDING)),
          ],
        ).paddingSymmetric(horizontal: 16),
        8.height,
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: boxDecorationDefault(
            shape: BoxShape.rectangle,
            color: context.cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (bookingController.bookingDetail.value.service.slug.contains(ServicesKeyConst.boarding)) ...[
                detailWidget(title: locale.value.dropOffDate, value: bookingController.bookingDetail.value.dropoffDateTime.isValidDateTime ? bookingController.bookingDetail.value.dropoffDateTime.dateInDMMMMyyyyFormat : ""),
                detailWidget(title: locale.value.dropOffTime, value: bookingController.bookingDetail.value.dropoffDateTime.isValidDateTime ? "At ${bookingController.bookingDetail.value.dropoffDateTime.timeInHHmmAmPmFormat}" : ""),
                detailWidget(title: locale.value.pickupDate, value: bookingController.bookingDetail.value.pickupDateTime.isValidDateTime ? bookingController.bookingDetail.value.pickupDateTime.dateInDMMMMyyyyFormat : ""),
                detailWidget(title: locale.value.pickupTime, value: bookingController.bookingDetail.value.pickupDateTime.isValidDateTime ? "At ${bookingController.bookingDetail.value.pickupDateTime.timeInHHmmAmPmFormat}" : ""),
              ],
              if (bookingController.bookingDetail.value.service.slug.contains(ServicesKeyConst.dayCare)) ...[
                detailWidget(title: locale.value.date, value: bookingController.bookingDetail.value.dayCareDate.isValidDateTime ? bookingController.bookingDetail.value.dayCareDate.dateInDMMMMyyyyFormat : ""),
                detailWidget(
                  title: locale.value.dropOffTime,
                  value: bookingController.bookingDetail.value.dropoffTime.isValidTime ? "At ${"1970-01-01 ${bookingController.bookingDetail.value.dropoffTime}".timeInHHmmAmPmFormat}" : "",
                ),
                detailWidget(
                  title: locale.value.pickupTime,
                  value: bookingController.bookingDetail.value.pickupTime.isValidTime ? "At ${"1970-01-01 ${bookingController.bookingDetail.value.pickupTime}".timeInHHmmAmPmFormat}" : "",
                ),
              ],
              if (!(bookingController.bookingDetail.value.service.slug.contains(ServicesKeyConst.boarding) || bookingController.bookingDetail.value.service.slug.contains(ServicesKeyConst.dayCare))) ...[
                detailWidget(title: locale.value.date, value: bookingController.bookingDetail.value.serviceDateTime.isValidDateTime ? bookingController.bookingDetail.value.serviceDateTime.dateInDMMMMyyyyFormat : ""),
                detailWidget(title: locale.value.time, value: bookingController.bookingDetail.value.serviceDateTime.isValidDateTime ? "At ${bookingController.bookingDetail.value.serviceDateTime.timeInHHmmAmPmFormat}" : ""),
              ],
              detailWidget(title: locale.value.favoriteFood, value: bookingController.bookingDetail.value.food.isNotEmpty ? bookingController.bookingDetail.value.food.first : ""),
              detailWidget(title: locale.value.favoriteActivity, value: bookingController.bookingDetail.value.activity.isNotEmpty ? bookingController.bookingDetail.value.activity.first : ""),
              detailWidget(title: locale.value.reason, value: bookingController.bookingDetail.value.veterinaryReason),
              detailWidget(title: locale.value.service, value: bookingController.bookingDetail.value.veterinaryServiceName),
              detailWidget(title: locale.value.bookingStatus, value: getBookingStatus(status: bookingController.bookingDetail.value.status), textColor: getBookingStatusColor(status: bookingController.bookingDetail.value.status)),
              detailWidget(
                  title: locale.value.paymentStatus,
                  value: getBookingPaymentStatus(status: bookingController.bookingDetail.value.payment.paymentStatus.capitalizeFirstLetter()),
                  textColor: getPriceStatusColor(paymentStatus: bookingController.bookingDetail.value.payment.paymentStatus)),
              detailWidget(title: locale.value.duration, value: bookingController.bookingDetail.value.duration.toFormattedDuration(showFullTitleHoursMinutes: true)),
              detailWidget(title: locale.value.address, value: getAddressByServiceElement(appointment: bookingController.bookingDetail.value)),
              6.height,
            ],
          ),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget paymentDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        Text(locale.value.paymentDetails, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
        8.height,
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: boxDecorationDefault(
            shape: BoxShape.rectangle,
            color: context.cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detailWidgetPrice(
                title: locale.value.price,
                value: bookingController.bookingDetail.value.price,
                textColor: textPrimaryColorGlobal,
              ),
              ...List.generate(
                bookingController.bookingDetail.value.payment.taxs.length,
                (index) => detailWidgetPrice(
                  title: bookingController.bookingDetail.value.payment.taxs[index].title,
                  value: bookingController.bookingDetail.value.payment.taxs[index].value,
                  textColor: isDarkMode.value ? textPrimaryColorGlobal : secondaryColor,
                  isSemiBoldText: true,
                ),
              ),
              detailWidgetPrice(
                title: locale.value.totalAmount,
                value: bookingController.bookingDetail.value.payment.totalAmount,
                textColor: getPriceStatusColor(paymentStatus: bookingController.bookingDetail.value.payment.paymentStatus),
              ),
              6.height,
            ],
          ),
        ).paddingSymmetric(horizontal: 16)
      ],
    );
  }

  Widget employeeInfoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        Text(locale.value.employeeInformation, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
        8.height,
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: boxDecorationDefault(
            shape: BoxShape.rectangle,
            color: context.cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => EmployeeDetailScreen(), arguments: bookingController.bookingDetail.value.employeeId);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      children: [
                        Text(locale.value.name, style: secondaryTextStyle()),
                        const Spacer(),
                        CachedImageWidget(
                          url: bookingController.bookingDetail.value.employeeImage,
                          height: 20,
                          width: 20,
                          circle: true,
                          radius: 20,
                          fit: BoxFit.cover,
                        ),
                        8.width,
                        Text(bookingController.bookingDetail.value.employeeName, style: primaryTextStyle(size: 12)),
                      ],
                    ).visible(bookingController.bookingDetail.value.employeeName.trim().isNotEmpty),
                  ).paddingBottom(8),
                  detailWidget(title: locale.value.designation, value: getEmployeeRoleByServiceElement(appointment: bookingController.bookingDetail.value)),
                  detailWidget(title: locale.value.contactNumber, value: bookingController.bookingDetail.value.employeeContact).onTap(() {
                    launchCall(bookingController.bookingDetail.value.employeeContact);
                  }),
                  detailWidget(title: locale.value.email, value: bookingController.bookingDetail.value.employeeEmail).onTap(() {
                    launchMail(bookingController.bookingDetail.value.employeeEmail);
                  }),
                ],
              ),
              6.height,
            ],
          ),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget petInfoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        Text(locale.value.petInformation, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
        8.height,
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: boxDecorationDefault(
            shape: BoxShape.rectangle,
            color: context.cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  myPetsScreenController.selectedPetProfile(bookingController.bookingDetail.value.petDetails!);
                  Get.to(() => PetProfileScreen());
                },
                behavior: HitTestBehavior.translucent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(locale.value.petName, style: secondaryTextStyle()),
                    const Spacer(),
                    Row(
                      children: [
                        CachedImageWidget(
                          url: bookingController.bookingDetail.value.petImage,
                          height: 20,
                          width: 20,
                          circle: true,
                          radius: 20,
                          fit: BoxFit.cover,
                        ),
                        8.width,
                      ],
                    ),
                    Text(bookingController.bookingDetail.value.petName, textAlign: TextAlign.right, style: primaryTextStyle(size: 12)),
                  ],
                ),
              ),
              8.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  detailWidget(title: locale.value.breed, value: bookingController.bookingDetail.value.petDetails!.breed),
                  detailWidget(title: locale.value.gender, value: bookingController.bookingDetail.value.petDetails!.gender.capitalizeFirstLetter()),
                  detailWidget(title: locale.value.weight, value: "${bookingController.bookingDetail.value.petDetails!.weight} ${bookingController.bookingDetail.value.petDetails!.weightUnit}"),
                  detailWidget(title: locale.value.height, value: "${bookingController.bookingDetail.value.petDetails!.height} ${bookingController.bookingDetail.value.petDetails!.heightUnit}"),
                ],
              ),
            ],
          ),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget serviceInfoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        Text(locale.value.serviceInformation, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
        8.height,
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          decoration: boxDecorationDefault(
            shape: BoxShape.rectangle,
            color: context.cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(bookingController.bookingDetail.value.training.name, style: primaryTextStyle(size: 12)).expand(),
                ],
              ),
              8.height,
              Row(
                children: [
                  Text(bookingController.bookingDetail.value.training.description, textAlign: TextAlign.left, style: secondaryTextStyle()).expand(),
                ],
              ),
              6.height,
            ],
          ),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget additionalInfoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        Text(locale.value.additionalInformation, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
        8.height,
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          decoration: boxDecorationDefault(
            shape: BoxShape.rectangle,
            color: context.cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(bookingController.bookingDetail.value.note, textAlign: TextAlign.left, style: secondaryTextStyle()).expand(),
                ],
              ),
              6.height,
            ],
          ),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget medicalReportWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        Text(locale.value.medicalReport, style: primaryTextStyle()),
        8.height,
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Loader(),
            ),
            GestureDetector(
              onTap: () {
                viewFiles(bookingController.bookingDetail.value.medicalReport);
              },
              behavior: HitTestBehavior.translucent,
              child: bookingController.bookingDetail.value.medicalReport.isImage
                  ? Container(
                      padding: const EdgeInsets.all(4),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: transparentColor),
                      child: CachedImageWidget(
                        url: bookingController.bookingDetail.value.medicalReport,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        radius: 8,
                      ),
                    )
                  : CommonPdfPlaceHolder(text: bookingController.bookingDetail.value.medicalReport.split("/").last),
            ),
          ],
        )
      ],
    );
  }

  Widget reviewPart(BuildContext context) {
    return Obx(
      () => bookingController.hasReview.value
          ? bookingController.showWriteReview.value
              ? addEditReview(context)
              : yourReview(context)
          : bookingController.showWriteReview.value
              ? addEditReview(context)
              : rateEmpNow(context),
    );
  }

  Widget rateEmpNow(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          32.height,
          Text(locale.value.review, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
          8.height,
          AppButton(
            width: Get.width,
            text: "${locale.value.rate} ${bookingController.bookingDetail.value.employeeName}",
            textStyle: appButtonTextStyleGray,
            color: isDarkMode.value ? context.cardColor : lightSecondaryColor,
            onTap: () {
              bookingController.showWriteReview(!bookingController.showWriteReview.value);
            },
          ).paddingSymmetric(horizontal: 16),
        ],
      ).visible(bookingController.yourReview.value.id.isNegative && !bookingController.hasReview.value),
    );
  }

  Widget zoomVideoCallBtn(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          32.height,
          AppButton(
            width: Get.width,
            text: locale.value.zoomVideoCall,
            textStyle: appButtonTextStyleGray,
            color: isDarkMode.value ? context.cardColor : lightSecondaryColor,
            onTap: () {
              commonLaunchUrl(bookingController.bookingDetail.value.joinVideoLink, launchMode: LaunchMode.externalApplication);
            },
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }

  Widget payNowBtn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        AppButton(
          width: Get.width,
          text: locale.value.payNow,
          textStyle: appButtonTextStyleWhite,
          color: completedStatusColor,
          onTap: () async {
            paymentController = PaymentController(
              bookingService: bookingController.bookingDetail.value.service,
              isFromBookingDetail: true,
              bid: bookingController.bookingDetail.value.id,
              amount: bookingController.bookingDetail.value.payment.totalAmount,
              paymentID: bookingController.bookingDetail.value.payment.id,
              tax: bookingController.bookingDetail.value.payment.taxs.map((e) => e.value).sumByDouble((p0) => p0),
            );
            paymentController.paymentOption(PaymentMethods.PAYMENT_METHOD_STRIPE);
            Get.to(() => const PaymentScreen())?.then((value) {
              if (value == true) {
                bookingController.init(showLoader: true);
              }
            });
          },
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget yourReview(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          32.height,
          Row(
            children: [
              Text(locale.value.yourReview, style: primaryTextStyle()),
              const Spacer(),
              GestureDetector(
                onTap: bookingController.handleEditReview,
                child: commonLeadingWid(imgPath: Assets.iconsIcEditReview, icon: Icons.edit_outlined, size: 20),
              ),
              16.width,
              GestureDetector(
                onTap: () {
                  bookingController.deleteReviewHandleClick();
                },
                child: commonLeadingWid(imgPath: Assets.iconsIcDeleteReview, icon: Icons.delete_outline, size: 20),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
          8.height,
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: Get.width,
            decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        CachedImageWidget(
                          url: loginUserData.value.profileImage,
                          firstName: loginUserData.value.firstName,
                          lastName: loginUserData.value.lastName,
                          height: 46,
                          width: 46,
                          fit: BoxFit.cover,
                          circle: true,
                        ),
                        10.width,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(loginUserData.value.userName, style: primaryTextStyle()),
                              ],
                            ),
                            4.height,
                            Row(
                              children: [
                                RatingBarWidget(
                                  size: 15,
                                  disable: true,
                                  activeColor: getRatingBarColor(bookingController.yourReview.value.rating),
                                  rating: bookingController.yourReview.value.rating.toDouble(),
                                  onRatingChanged: (aRating) {
                                    bookingController.rating = 5;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(bookingController.yourReview.value.createdAt.dateInyyyyMMddHHmmFormat.timeAgoWithLocalization, style: secondaryTextStyle()),
                      ],
                    ).expand(),
                  ],
                ),
                16.height,
                Text(bookingController.yourReview.value.reviewMsg, style: secondaryTextStyle()),
              ],
            ),
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }

  Widget addEditReview(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          32.height,
          Row(
            children: [
              Text('${locale.value.yourReview}  ${locale.value.to}  ${bookingController.bookingDetail.value.employeeName}', style: primaryTextStyle()),
              const Spacer(),
              GestureDetector(
                onTap: bookingController.showReview,
                child: commonLeadingWid(imgPath: '', icon: Icons.close_outlined, size: 20),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
          8.height,
          Text(locale.value.yourFeedbackWillImprove, style: secondaryTextStyle()).paddingSymmetric(horizontal: 16),
          8.height,
          Row(
            children: [
              RatingBarWidget(
                size: 24,
                allowHalfRating: true,
                activeColor: getRatingBarColor(bookingController.selectedRating.value),
                inActiveColor: ratingColor,
                rating: bookingController.selectedRating.value,
                onRatingChanged: (rating) {
                  bookingController.selectedRating(rating);
                },
              ).expand(),
            ],
          ).paddingSymmetric(horizontal: 16),
          8.height,
          AppTextField(
            controller: bookingController.reviewCont,
            textStyle: primaryTextStyle(size: 12),
            textFieldType: TextFieldType.MULTILINE,
            minLines: 5,
            enableChatGPT: appConfigs.value.enableChatGpt,
            promptFieldInputDecorationChatGPT: inputDecoration(context, hintText: locale.value.writeHere, fillColor: context.scaffoldBackgroundColor, filled: true),
            testWithoutKeyChatGPT: appConfigs.value.testWithoutKey,
            loaderWidgetForChatGPT: const ChatGPTLoadingWidget(),
            decoration: inputDecoration(
              context,
              fillColor: context.cardColor,
              filled: true,
              hintText: locale.value.writeYourFeedbackHere,
            ),
          ).paddingSymmetric(horizontal: 16),
          16.height,
          AppButton(
            width: Get.width,
            text: locale.value.submit,
            textStyle: const TextStyle(color: containerColor),
            onTap: () {
              if (bookingController.selectedRating.value > 0) {
                bookingController.saveReview();
              } else {
                toast(locale.value.pleaseSelectRatings);
              }
            },
          ).paddingSymmetric(horizontal: 16),
          32.height,
        ],
      ),
    );
  }

  bool get showBookingDetail => bookingController.bookingDetail.value.duration.toFormattedDuration(showFullTitleHoursMinutes: true).isNotEmpty || getAddressByServiceElement(appointment: bookingController.bookingDetail.value).isNotEmpty;

  Widget additionalFacilityWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        Text(locale.value.additionalFacility, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
        AnimatedScrollView(
          children: [
            8.height,
            Container(
              decoration: boxDecorationDefault(
                shape: BoxShape.rectangle,
                color: context.cardColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: bookingController.facilities.map(
                  (element) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.height,
                        Text(element.name, style: primaryTextStyle()),
                        8.height,
                        Text(element.description, style: secondaryTextStyle()),
                        16.height,
                      ],
                    ).paddingSymmetric(horizontal: 16);
                  },
                ).toList(),
              ),
            ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ],
    );
  }
}
