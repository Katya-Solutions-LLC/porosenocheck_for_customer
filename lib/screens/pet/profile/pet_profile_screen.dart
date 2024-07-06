import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';
import 'package:porosenocheck/screens/pet/add_pet_info_controller.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/cached_image_widget.dart';
import '../../../components/common_profile_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_common.dart';
import '../../auth/model/login_response.dart';
import '../../booking_module/booking_detail/booking_detail_screen.dart';
import '../../booking_module/model/booking_data_model.dart';
import '../../booking_module/services/service_navigation.dart';
import '../../dashboard/dashboard_res_model.dart';
import '../../home/home_controller.dart';
import '../../pet_sitter/employee_detail_screen.dart';
import '../model/pet_note_model.dart';
import '../my_pets_controller.dart';
import 'pet_profile_controller.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/empty_error_state_widget.dart';
import '../add_pet_pageview.dart';
import 'add_notes.dart';

class PetProfileScreen extends StatelessWidget {
  PetProfileScreen({Key? key}) : super(key: key);
  final PetProfileController petProfileController = Get.put(PetProfileController());
  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.profile,
      isLoading: petProfileController.isLoading,
      actions: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => AddPetInfoScreen(), arguments: myPetsScreenController.selectedPetProfile.value);
              },
              child: commonLeadingWid(imgPath: Assets.iconsIcEditReview, icon: Icons.edit_outlined, size: 20),
            ),
            16.width,
            GestureDetector(
              onTap: () {
                showConfirmDialogCustom(
                  getContext,
                  primaryColor: primaryColor,
                  negativeText: locale.value.cancel,
                  positiveText: locale.value.yes,
                  onAccept: (_) {
                    petProfileController.deletePet();
                  },
                  dialogType: DialogType.DELETE,
                  title: locale.value.areYouSureYou,
                );
              },
              child: commonLeadingWid(imgPath: Assets.iconsIcDeleteReview, icon: Icons.delete_outline, size: 20),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ],
      body: AnimatedScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        onSwipeRefresh: () async {
          petProfileController.page(1);
          return await petProfileController.getNoteApi();
        },
        children: [
          ProfilePicWidget(
            heroTag: "${myPetsScreenController.selectedPetProfile.value.name}${myPetsScreenController.selectedPetProfile.value.id}",
            profileImage: myPetsScreenController.selectedPetProfile.value.petImage,
            firstName: myPetsScreenController.selectedPetProfile.value.name,
            userName: myPetsScreenController.selectedPetProfile.value.name,
            subInfo: "${locale.value.breed}: ${myPetsScreenController.selectedPetProfile.value.breed}",
            onCameraTap: () {
              AddPetInfoController addPetInfoController = AddPetInfoController(isProfilePhoto: true, petId: myPetsScreenController.selectedPetProfile.value.id);
              addPetInfoController.showBottomSheet(context);
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.04),
              Container(
                height: Get.height * 0.11,
                decoration: boxDecorationDefault(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: context.cardColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      attributesWid(title: locale.value.gender, data: myPetsScreenController.selectedPetProfile.value.gender.capitalizeFirstLetter()),
                      const VerticalDivider(color: borderColor, indent: 15, endIndent: 15),
                      attributesWid(title: locale.value.birthday, data: myPetsScreenController.selectedPetProfile.value.dateOfBirth.dateInMMMMDyyyyFormat),
                      const VerticalDivider(color: borderColor, indent: 15, endIndent: 15),
                      attributesWid(title: locale.value.weight, data: "${myPetsScreenController.selectedPetProfile.value.weight.toString()} ${myPetsScreenController.selectedPetProfile.value.weightUnit.toString()}"),
                    ],
                  ),
                ),
              ).paddingSymmetric(horizontal: 16),
              if (!homeScreenController.dashboardData.value.upcommingBooking.id.isNegative) ...[
                32.height,
                Text(locale.value.reminder, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
                8.height,
                GestureDetector(
                  onTap: () {
                    Get.to(() => BookingDetailScreen(),
                        arguments: BookingDataModel(
                            id: homeScreenController.dashboardData.value.upcommingBooking.id, service: SystemService(name: homeScreenController.dashboardData.value.upcommingBooking.service.name), payment: PaymentDetails(), training: Training()));
                  },
                  child: Container(
                    decoration: boxDecorationDefault(
                      color: context.cardColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.height,
                            Row(
                              children: [
                                Text(getServiceNameByServiceElement(serviceSlug: homeScreenController.dashboardData.value.upcommingBooking.service.slug), style: primaryTextStyle()),
                                4.width,
                                Text(
                                  '#${homeScreenController.dashboardData.value.upcommingBooking.id}',
                                  style: primaryTextStyle(size: 16, decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                            8.height,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                commonLeadingWid(imgPath: Assets.navigationIcCalendarOutlined, icon: Icons.calendar_month_outlined, color: primaryColor).paddingBottom(10),
                                12.width,
                                detailWidget(title: "", value: scheduleDate),
                                detailWidget(title: " @", value: scheduleTime),
                                // Text(homeScreenController.dashboardData.value.upcommingBooking.startDateTime.dateInMMMMDyyyyAtHHmmAmPmFormat, style: secondaryTextStyle()),
                              ],
                            ),
                            if (homeScreenController.dashboardData.value.upcommingBooking.employeeName.trim().isNotEmpty) ...[
                              GestureDetector(
                                onTap: homeScreenController.dashboardData.value.upcommingBooking.employeeId > 0
                                    ? () {
                                        Get.to(() => EmployeeDetailScreen(), arguments: homeScreenController.dashboardData.value.upcommingBooking.employeeId);
                                      }
                                    : null,
                                behavior: HitTestBehavior.translucent,
                                child: Row(
                                  children: [
                                    CachedImageWidget(
                                      url: homeScreenController.dashboardData.value.upcommingBooking.employeeImage,
                                      height: 20,
                                      width: 20,
                                      circle: true,
                                      radius: 20,
                                      fit: BoxFit.cover,
                                    ),
                                    12.width,
                                    Text(homeScreenController.dashboardData.value.upcommingBooking.employeeName, style: secondaryTextStyle()),
                                  ],
                                ),
                              ),
                            ],
                            16.height,
                          ],
                        ).paddingSymmetric(horizontal: 16),
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 16),
                ),
              ],
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      16.width,
                      Text('${locale.value.notesFor} ${myPetsScreenController.selectedPetProfile.value.name}', style: primaryTextStyle()),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      petProfileController.selectedNote(NotePetModel(createdbyUser: UserData(), isPrivate: false.obs));
                      Get.to(() => AddNote());
                    },
                    child: Text(locale.value.addNote, style: primaryTextStyle(color: primaryColor, decorationColor: primaryColor)),
                  )
                ],
              ),
              Obx(
                () => SnapHelperWidget(
                  future: petProfileController.notes.value,
                  errorBuilder: (error) {
                    return NoDataWidget(
                      title: error,
                      retryText: locale.value.reload,
                      imageWidget: const ErrorStateWidget(),
                      /* onRetry: () {
                        petProfileController.getNoteApi();
                      },*/
                    ).paddingSymmetric(horizontal: 16);
                  },
                  loadingWidget: const LoaderWidget(),
                  onSuccess: (notes) {
                    return notes.isEmpty
                        ? NoDataWidget(
                            title: locale.value.noNewNotes,
                            subTitle: "${locale.value.thereAreCurrentlyNoNotes} ${myPetsScreenController.selectedPetProfile.value.name}",
                            imageWidget: const EmptyStateWidget(),
                            retryText: locale.value.reload,
                            /*  onRetry: () {
                              petProfileController.page(1);
                              petProfileController.isLoading(true);
                              petProfileController.getNoteApi();
                            },*/
                          ).paddingSymmetric(horizontal: 16)
                        : Obx(
                            () => AnimatedListView(
                              shrinkWrap: true,
                              itemCount: notes.length,
                              listAnimationType: ListAnimationType.FadeIn,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext contex, index) {
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
                                                      url: notes[index].createdbyUser.profileImage,
                                                      height: 22,
                                                      width: 22,
                                                      circle: true,
                                                      radius: 22,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    12.width,
                                                    Text(notes[index].createdbyUser.userName, style: secondaryTextStyle()),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        petProfileController.selectedNote(notes[index]);
                                                        petProfileController.titleCont.text = petProfileController.selectedNote.value.title;
                                                        petProfileController.noteCont.text = petProfileController.selectedNote.value.description;
                                                        Get.to(() => AddNote());
                                                      },
                                                      child: commonLeadingWid(imgPath: Assets.iconsIcEditReview, icon: Icons.edit_outlined, size: 20),
                                                    ),
                                                    16.width,
                                                    GestureDetector(
                                                      onTap: () {
                                                        showConfirmDialogCustom(
                                                          getContext,
                                                          primaryColor: primaryColor,
                                                          negativeText: locale.value.cancel,
                                                          positiveText: locale.value.yes,
                                                          onAccept: (_) {
                                                            petProfileController.selectedNote(notes[index]);
                                                            petProfileController.deleteNote();
                                                          },
                                                          dialogType: DialogType.DELETE,
                                                          title: locale.value.areYouSureWantDeleteNote,
                                                        );
                                                      },
                                                      child: commonLeadingWid(imgPath: Assets.iconsIcDelete, color: Colors.redAccent, icon: Icons.delete_outline, size: 20),
                                                    ),
                                                  ],
                                                ).visible(notes[index].createdBy == loginUserData.value.id || notes[index].createdbyUser.userType.contains(IS_ADMIN)),
                                              ],
                                            ).paddingBottom(8),
                                            Text(notes[index].title, textAlign: TextAlign.left, style: primaryTextStyle()),
                                            8.height,
                                            Text(notes[index].description, textAlign: TextAlign.left, style: secondaryTextStyle()),
                                          ],
                                        ).paddingAll(16).expand(),
                                      ],
                                    ),
                                  ).paddingTop(index == 0 ? 0 : 12),
                                );
                              },
                              onSwipeRefresh: () async {
                                petProfileController.page(1);
                                return await petProfileController.getNoteApi();
                              },
                            ).paddingSymmetric(horizontal: 16),
                          );
                  },
                ),
              ),
              32.height,
            ],
          ),
        ],
        onNextPage: () {
          if (!petProfileController.isLastPage.value) {
            petProfileController.page(petProfileController.page.value + 1);
            petProfileController.getNoteApi();
          }
        },
      ),
    );
  }

  Widget attributesWid({
    required String title,
    required String data,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, textAlign: TextAlign.center, style: secondaryTextStyle()),
        8.height,
        Text(data.validate(value: "-"), textAlign: TextAlign.center, style: primaryTextStyle()),
      ],
    );
  }

  String get scheduleDate {
    try {
      return homeScreenController.dashboardData.value.upcommingBooking.startDateTime.isValidDateTime ? homeScreenController.dashboardData.value.upcommingBooking.startDateTime.dateInDMMMMyyyyFormat : "";
    } catch (e) {
      log('get scheduleDate E: $e');
      return "";
    }
  }

  String get scheduleTime {
    try {
      if (homeScreenController.dashboardData.value.upcommingBooking.service.slug.contains(ServicesKeyConst.boarding)) {
        return homeScreenController.dashboardData.value.upcommingBooking.dropoffDateTime.isValidDateTime ? " ${homeScreenController.dashboardData.value.upcommingBooking.dropoffDateTime.timeInHHmmAmPmFormat}" : "";
      } else {
        return homeScreenController.dashboardData.value.upcommingBooking.serviceDateTime.isValidDateTime ? " ${homeScreenController.dashboardData.value.upcommingBooking.serviceDateTime.timeInHHmmAmPmFormat}" : "";
      }
    } catch (e) {
      log('get scheduleTime E: $e');
      return "";
    }
  }

  Widget detailWidget({required String title, required String value, Color? textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: secondaryTextStyle()),
        Text(value, style: secondaryTextStyle()),
      ],
    ).paddingBottom(10).visible(value.isNotEmpty);
  }
}
