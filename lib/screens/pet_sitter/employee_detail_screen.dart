import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/common_base.dart';

import '../../components/app_scaffold.dart';
import '../../components/cached_image_widget.dart';
import '../../components/loader_widget.dart';
import '../../generated/assets.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/empty_error_state_widget.dart';
import '../booking_module/services/service_navigation.dart';
import 'employee_detail_controller.dart';

class EmployeeDetailScreen extends StatelessWidget {
  EmployeeDetailScreen({super.key});

  final EmployeeDetailController employeeDetailController = Get.put(EmployeeDetailController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.aboutEmployee,
      body: Obx(
        () => SnapHelperWidget(
          future: employeeDetailController.getUserProfileDetail.value,
          errorBuilder: (error) {
            return NoDataWidget(
              title: error,
              retryText: locale.value.reload,
              imageWidget: const ErrorStateWidget(),
              onRetry: () {
                employeeDetailController.init();
              },
            ).paddingSymmetric(horizontal: 32);
          },
          loadingWidget: const LoaderWidget(),
          onSuccess: (userDetail) {
            return Stack(
              children: [
                AnimatedScrollView(
                  listAnimationType: ListAnimationType.FadeIn,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      decoration: boxDecorationDefault(
                        color: context.cardColor,
                        // border: Border.all(color: isDarkMode.value ? Colors.white54 : context.primaryColor.withOpacity(0.2), width: 2),
                        borderRadius: radius(),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (userDetail.data.profileImage.validate().isNotEmpty)
                                CachedImageWidget(
                                  url: userDetail.data.profileImage,
                                  height: 70,
                                  width: 70,
                                  circle: true,
                                  fit: BoxFit.cover,
                                ),
                              16.width,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  10.height,
                                  Text(userDetail.data.fullName, style: primaryTextStyle(size: 13)),
                                  4.height,
                                  Text(getEmployeeRoleByUserType(userType: userDetail.data.userType), style: primaryTextStyle(size: 11)),
                                  10.height,
                                  //DisabledRatingBarWidget(rating: data.handymanData!.handymanRating.validate().toDouble()),
                                ],
                              ).expand(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (userDetail.data.aboutSelf.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(locale.value.about, style: primaryTextStyle(size: 12)),
                                  8.height,
                                  Text(userDetail.data.aboutSelf, style: secondaryTextStyle()),
                                  16.height,
                                ],
                              ),
                            if (userDetail.data.expert.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(locale.value.expertise, style: primaryTextStyle(size: 12)),
                                  8.height,
                                  Text(userDetail.data.expert, style: secondaryTextStyle()),
                                  16.height,
                                ],
                              ),
                            Text(locale.value.personalInfo, style: primaryTextStyle(size: 12)),
                            TextIcon(
                              spacing: 10,
                              edgeInsets: const EdgeInsets.only(bottom: 8, top: 8),
                              onTap: () {
                                launchMail(userDetail.data.email.validate());
                              },
                              prefix: Assets.iconsIcMail.iconImage(fit: BoxFit.contain),
                              text: userDetail.data.email,
                              textStyle: secondaryTextStyle(),
                              expandedText: true,
                            ),
                            if (userDetail.data.mobile.isNotEmpty)
                              TextIcon(
                                spacing: 10,
                                edgeInsets: const EdgeInsets.only(bottom: 8, top: 4),
                                onTap: () {
                                  launchCall(userDetail.data.mobile);
                                },
                                prefix: Assets.iconsCall.iconImage(fit: BoxFit.contain),
                                text: userDetail.data.mobile,
                                textStyle: secondaryTextStyle(),
                                expandedText: true,
                              ),
                            if (userDetail.data.facebookLink.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  8.height,
                                  Text("Facebook", style: primaryTextStyle(size: 12)),
                                  8.height,
                                  Text(userDetail.data.facebookLink, style: secondaryTextStyle()),
                                  16.height,
                                ],
                              ),
                            if (userDetail.data.instagramLink.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Instagram", style: primaryTextStyle(size: 12)),
                                  8.height,
                                  Text(userDetail.data.instagramLink, style: secondaryTextStyle()),
                                  16.height,
                                ],
                              ),
                            if (userDetail.data.twitterLink.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Twitter", style: primaryTextStyle(size: 12)),
                                  8.height,
                                  Text(userDetail.data.twitterLink, style: secondaryTextStyle()),
                                  16.height,
                                ],
                              ),
                            if (userDetail.data.dribbbleLink.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Dribbble", style: primaryTextStyle(size: 12)),
                                  8.height,
                                  Text(userDetail.data.dribbbleLink, style: secondaryTextStyle()),
                                  16.height,
                                ],
                              ),
                          ],
                        ),
                      ],
                    ).paddingAll(16),
                  ],
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppButton(
                        color: lightSecondaryColor,
                        onTap: () {
                          if (userDetail.data.mobile.isEmpty) {
                            toast("${userDetail.data.fullName} ${locale.value.hasNotSharedTheir}");
                          } else {
                            launchCall(userDetail.data.mobile);
                          }
                        },
                        child: commonLeadingWid(
                          imgPath: Assets.iconsCall,
                          icon: Icons.mail_outlined,
                          color: secondaryColor,
                        ),
                      ).expand(),
                      32.width,
                      AppButton(
                        child: commonLeadingWid(
                          imgPath: Assets.iconsIcMail,
                          icon: Icons.mail_outlined,
                          color: Colors.white,
                        ),
                        onTap: () {
                          log('PETSITTER.EMAIL: ${userDetail.data.email}');
                          if (userDetail.data.email.isEmpty) {
                            toast("${userDetail.data.fullName} ${locale.value.hasNotSharedTheirEmail}");
                          } else {
                            launchMail(userDetail.data.email);
                          }
                        },
                      ).expand(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
