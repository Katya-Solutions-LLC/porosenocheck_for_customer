import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/screens/shop/order/new_order_screen.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/common_profile_widget.dart';
import '../../../generated/assets.dart';

import 'edit_user_profile_controller.dart';
import '../../pet/my_pets_controller.dart';
import 'profile_controller.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../pet/add_pet_pageview.dart';
import '../other/settings_screen.dart';
import '../other/about_us_screen.dart';
import 'edit_user_profile.dart';
import '../../pet/my_pets_screen.dart';
import 'select_address_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppScaffold(
        hideAppBar: true,
        isLoading: profileController.isLoading,
        body: AnimatedScrollView(
          padding: const EdgeInsets.only(top: 39),
          children: [
            CommonAppBar(
              title: locale.value.profile,
              hasLeadingWidget: false,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => ProfilePicWidget(
                      heroTag: loginUserData.value.profileImage,
                      profileImage: loginUserData.value.profileImage,
                      firstName: loginUserData.value.firstName,
                      lastName: loginUserData.value.lastName,
                      userName: loginUserData.value.userName,
                      subInfo: loginUserData.value.email,
                      onCameraTap: () {
                        EditUserProfileController editUserProfileController = EditUserProfileController(isProfilePhoto: true);
                        editUserProfileController.showBottomSheet(context);
                      },
                    )),
                32.height,
                SettingItemWidget(
                  title: locale.value.editProfile,
                  subTitle: locale.value.personalizeYourProfile,
                  splashColor: transparentColor,
                  onTap: () {
                    Get.to(() => EditUserProfileScreen(), duration: const Duration(milliseconds: 800));
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.imagesIcEditprofileOutlined, icon: Icons.person_3_outlined, color: primaryColor),
                  trailing: trailing,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
                commonDivider,
                SettingItemWidget(
                  title: locale.value.myPets,
                  subTitle: locale.value.petProfileDetails,
                  splashColor: transparentColor,
                  onTap: () {
                    myPetsScreenController.init();
                    Get.to(() => const MyPetsScreen());
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.profileIconsIcMyPets, icon: Icons.pets_outlined, color: secondaryColor),
                  trailing: trailing,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
                commonDivider,
                SettingItemWidget(
                  title: locale.value.addPet,
                  subTitle: locale.value.addYourPetInformation,
                  splashColor: transparentColor,
                  onTap: () {
                    Get.to(() => AddPetInfoScreen());
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.profileIconsIcAddPet, icon: Icons.add_box_outlined, color: primaryColor),
                  trailing: trailing,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
                commonDivider,
                SettingItemWidget(
                  title: locale.value.orders,
                  subTitle: locale.value.seeYourOrders,
                  splashColor: transparentColor,
                  onTap: () {
                    Get.to(() => NewOrderScreen());
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.iconsIcOrder, icon: Icons.summarize_outlined, color: secondaryColor),
                  trailing: trailing,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
                commonDivider,
                SettingItemWidget(
                  title: locale.value.myAddresses,
                  subTitle: locale.value.manageYourAddresses,
                  splashColor: transparentColor,
                  onTap: () {
                    Get.to(() => SelectAddressScreen(isFromProfile: true));
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.iconsIcMyAddress, icon: Icons.location_on_outlined, color: primaryColor),
                  trailing: trailing,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
                commonDivider,
                SettingItemWidget(
                  title: locale.value.settings,
                  subTitle: "${locale.value.changePassword},${locale.value.themeAndMore}",
                  splashColor: transparentColor,
                  onTap: () {
                    Get.to(() => SettingScreen());
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.profileIconsIcSettingOutlined, icon: Icons.settings_outlined, color: secondaryColor),
                  trailing: trailing,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
                commonDivider,
                SettingItemWidget(
                  title: locale.value.rateApp,
                  subTitle: locale.value.showSomeLoveShare,
                  splashColor: transparentColor,
                  onTap: () async {
                    //TODO In app review
                    /* final InAppReview inAppReview = InAppReview.instance;

                    if (await inAppReview.isAvailable()) {
                      inAppReview.requestReview();
                    } */
                    handleRate();
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.profileIconsIcStarOutlined, icon: Icons.star_outline_rounded, color: primaryColor),
                  trailing: trailing,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
                commonDivider,
                SettingItemWidget(
                  title: locale.value.aboutApp,
                  subTitle: locale.value.privacyPolicyTerms,
                  splashColor: transparentColor,
                  onTap: () {
                    Get.to(() => const AboutScreen());
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.profileIconsIcInfoOutlined, icon: Icons.info_outline_rounded, color: secondaryColor),
                  trailing: trailing,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
                commonDivider,
                SettingItemWidget(
                  title: locale.value.logout,
                  subTitle: locale.value.securelyLogOutOfAccount,
                  splashColor: transparentColor,
                  onTap: () {
                    showConfirmDialogCustom(
                      primaryColor: primaryColor,
                      context,
                      negativeText: locale.value.cancel,
                      positiveText: locale.value.logout,
                      onAccept: (_) {
                        profileController.handleLogout();
                      },
                      dialogType: DialogType.CONFIRMATION,
                      subTitle: locale.value.doYouWantToLogout,
                      title: locale.value.ohNoYouAreLeaving,
                    );
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.profileIconsIcLogoutOutlined, icon: Icons.logout_outlined, color: primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
                30.height,
                SnapHelperWidget<PackageInfoData>(
                  future: getPackageInfo(),
                  onSuccess: (data) {
                    return VersionInfoWidget(prefixText: 'v', textStyle: primaryTextStyle()).center();
                  },
                ),
                32.height,
              ],
            ),
          ],
        ).visible(!updateUi.value),
      ),
    );
  }

  Widget get trailing => Icon(Icons.arrow_forward_ios, size: 12, color: darkGray.withOpacity(0.5));
}
