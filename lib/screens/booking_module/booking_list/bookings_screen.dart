import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/booking_module/booking_list/booking_card.dart';
import 'package:porosenocheck/screens/booking_module/booking_list/bookings_screen_shimmer.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/bottom_selection_widget.dart';
import '../../../components/search_booking_widget.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/empty_error_state_widget.dart';
import '../services/service_navigation.dart';
import 'bookings_controller.dart';
import '../../../main.dart';

class BookingsScreen extends StatelessWidget {
  BookingsScreen({Key? key}) : super(key: key);
  final BookingsController bookingsController = Get.put(BookingsController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.bookings,
      hasLeadingWidget: false,
      isLoading: bookingsController.isLoading,
      actions: [
        IconButton(
          onPressed: () async {
            hideKeyboard(context);
            handleFilterClick(context);
          },
          icon: commonLeadingWid(imgPath: Assets.iconsIcFilter, color: switchColor, icon: Icons.filter_alt_outlined, size: 24),
        ),
      ],
      body: SizedBox(
        height: Get.height,
        child: Obx(
          () => Column(
            children: [
              SearchBookingWidget(
                bookingsController: bookingsController,
                onFieldSubmitted: (p0) {
                  hideKeyboard(context);
                },
              ).paddingSymmetric(horizontal: 16),
              16.height,
              SnapHelperWidget(
                future: bookingsController.getBookings.value,
                initialData: bookingsController.bookings.isNotEmpty ? bookingsController.bookings : null,
                errorBuilder: (error) {
                  return NoDataWidget(
                    title: error,
                    retryText: locale.value.reload,
                    imageWidget: const ErrorStateWidget(),
                    onRetry: () {
                      bookingsController.page(1);
                      bookingsController.getBookingList();
                    },
                  ).paddingSymmetric(horizontal: 16);
                },
                loadingWidget: const BookingsScreenShimmer(),
                onSuccess: (booking) {
                  return Obx(
                    () => AnimatedListView(
                      shrinkWrap: true,
                      itemCount: booking.length,
                      listAnimationType: ListAnimationType.None,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      emptyWidget: NoDataWidget(
                        title: locale.value.noBookingsFound,
                        imageWidget: const EmptyStateWidget(),
                        subTitle: locale.value.thereAreCurrentlyNo,
                      ).paddingSymmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        return BookingCard(
                          appointment: booking[index],
                          onUpdateBooking: () {
                            bookingsController.page(1);
                            bookingsController.getBookingList();
                          },
                        );
                      },
                      onNextPage: () async {
                        if (!bookingsController.isLastPage.value) {
                          bookingsController.page(bookingsController.page.value + 1);
                          bookingsController.getBookingList();
                        }
                      },
                      onSwipeRefresh: () async {
                        bookingsController.page(1);
                        bookingsController.getBookingList(showloader: false);
                        return await Future.delayed(const Duration(seconds: 2));
                      },
                    ),
                  );
                },
              ).expand(),
            ],
          ),
        ).paddingTop(16),
      ),
    );
  }

  void handleFilterClick(BuildContext context) {
    doIfLoggedIn(context, () {
      serviceCommonBottomSheet(
        context,
        child: Obx(
          () => BottomSelectionSheet(
            heightRatio: 0.68,
            title: locale.value.filterBy,
            hideSearchBar: true,
            hintText: locale.value.searchForStatus,
            searchTextCont: TextEditingController(),
            hasError: false,
            isLoading: bookingsController.isLoading,
            isEmpty: allStatus.isEmpty,
            noDataTitle: locale.value.statusListIsEmpty,
            noDataSubTitle: locale.value.thereAreNoStatus,
            listWidget: statusListWid(context),
          ),
        ),
      );
    });
  }

  Widget statusListWid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.value.bookingStatus, style: secondaryTextStyle()),
        8.height,
        AnimatedWrap(
          runSpacing: 8,
          spacing: 6,
          itemCount: allStatus.length,
          listAnimationType: ListAnimationType.FadeIn,
          itemBuilder: (_, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  if (bookingsController.selectedStatus.contains(allStatus[index].status)) {
                    bookingsController.selectedStatus.remove(allStatus[index].status);
                  } else {
                    bookingsController.selectedStatus.add(allStatus[index].status);
                  }
                },
                child: Container(
                  width: Get.width / 3.71,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: boxDecorationDefault(
                    color: bookingsController.selectedStatus.contains(allStatus[index].status)
                        ? isDarkMode.value
                            ? primaryColor
                            : lightPrimaryColor
                        : isDarkMode.value
                            ? lightPrimaryColor2
                            : Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        size: 14,
                        color: isDarkMode.value ? whiteColor : primaryColor,
                      ).visible(bookingsController.selectedStatus.contains(allStatus[index].status)),
                      4.width.visible(bookingsController.selectedStatus.contains(allStatus[index].status)),
                      Text(
                        getBookingStatus(status: allStatus[index].status),
                        style: secondaryTextStyle(
                          color: bookingsController.selectedStatus.contains(allStatus[index].status)
                              ? isDarkMode.value
                                  ? whiteColor
                                  : primaryColor
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        16.height,
        Text(locale.value.service, style: secondaryTextStyle()),
        8.height,
        AnimatedWrap(
          runSpacing: 8,
          spacing: 6,
          itemCount: serviceList.length,
          listAnimationType: ListAnimationType.FadeIn,
          itemBuilder: (_, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  if (bookingsController.selectedService.contains(serviceList[index].name)) {
                    bookingsController.selectedService.remove(serviceList[index].name);
                  } else {
                    bookingsController.selectedService.add(serviceList[index].name);
                  }
                },
                child: Container(
                  width: Get.width / 3.71,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: boxDecorationDefault(
                    color: bookingsController.selectedService.contains(serviceList[index].name)
                        ? isDarkMode.value
                            ? primaryColor
                            : lightPrimaryColor
                        : isDarkMode.value
                            ? lightPrimaryColor2
                            : Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        size: 14,
                        color: isDarkMode.value ? whiteColor : primaryColor,
                      ).visible(bookingsController.selectedService.contains(serviceList[index].name)),
                      4.width.visible(bookingsController.selectedService.contains(serviceList[index].name)),
                      Text(
                        getServiceNameByServiceElement(serviceSlug: serviceList[index].slug),
                        style: secondaryTextStyle(
                          color: bookingsController.selectedService.contains(serviceList[index].name)
                              ? isDarkMode.value
                                  ? whiteColor
                                  : primaryColor
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppButton(
              text: locale.value.clearFilter,
              textStyle: appButtonTextStyleGray,
              color: lightSecondaryColor,
              onTap: () {
                Get.back();
                bookingsController.selectedStatus.clear();
                bookingsController.selectedService.clear();
                bookingsController.page(1);
                bookingsController.getBookingList();
              },
            ).expand(),
            16.width,
            AppButton(
              text: locale.value.apply,
              textStyle: appButtonTextStyleWhite,
              onTap: () {
                if (bookingsController.selectedStatus.isEmpty && bookingsController.selectedService.isEmpty) {
                  toast(locale.value.pleaseSelectAnItem);
                } else {
                  Get.back();
                  bookingsController.page(1);
                  bookingsController.getBookingList();
                }
              },
            ).expand(),
          ],
        ),
      ],
    ).expand();
  }
}
