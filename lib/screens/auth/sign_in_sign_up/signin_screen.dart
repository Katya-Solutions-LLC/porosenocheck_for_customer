import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';
import 'package:porosenocheck/configs.dart';
import 'package:porosenocheck/main.dart';

import '../../../components/app_logo_widget.dart';
import '../../../components/app_scaffold.dart';
import '../../../generated/assets.dart';
import 'sign_in_controller.dart';

import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../password/forget_password_screen.dart';
import 'signup_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final SignInController signInController = Get.put(SignInController());
  final GlobalKey<FormState> _signInformKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      isLoading: signInController.isLoading,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  65.height,
                  Image.asset(
                    Assets.imagesLogo,
                    height: Constants.appLogoSize,
                    width: Constants.appLogoSize,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const AppLogoWidget(),
                  ),
                  16.height,
                  Text(
                    '${locale.value.hello} ${signInController.userName.value.isNotEmpty ? signInController.userName.value : locale.value.guest}!',
                    style: primaryTextStyle(size: 24),
                  ),
                  8.height,
                  Text(
                    signInController.userName.value.isNotEmpty ? '${locale.value.welcomeBackToThe}  $APP_NAME  ${locale.value.app}' : '${locale.value.welcomeToThe} $APP_NAME ${locale.value.care}',
                    style: secondaryTextStyle(size: 14),
                  ),
                  50.height,
                  Form(
                    key: _signInformKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTextField(
                          title: locale.value.email,
                          textStyle: primaryTextStyle(size: 12),
                          controller: signInController.emailCont,
                          focus: signInController.emailFocus,
                          nextFocus: signInController.passwordFocus,
                          textFieldType: TextFieldType.EMAIL,
                          decoration: inputDecoration(
                            context,
                            fillColor: context.cardColor,
                            filled: true,
                            hintText: "${locale.value.eG} merry_456@gmail.com",
                          ),
                          suffix: Assets.iconsIcMail.iconImage(fit: BoxFit.contain).paddingAll(14),
                        ),
                        16.height,
                        AppTextField(
                          title: locale.value.password,
                          textStyle: primaryTextStyle(size: 12),
                          controller: signInController.passwordCont,
                          focus: signInController.passwordFocus,
                          // Optional
                          textFieldType: TextFieldType.PASSWORD,
                          decoration: inputDecoration(
                            context,
                            fillColor: context.cardColor,
                            filled: true,
                            hintText: "••••••••",
                          ),
                          suffixPasswordVisibleWidget: commonLeadingWid(imgPath: Assets.iconsIcEye, icon: Icons.password_outlined, size: 14).paddingAll(12),
                          suffixPasswordInvisibleWidget: commonLeadingWid(imgPath: Assets.iconsIcEyeSlash, icon: Icons.password_outlined, size: 14).paddingAll(12),
                        ),
                        8.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => InkWell(
                                onTap: signInController.toggleSwitch,
                                borderRadius: radius(),
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.75,
                                      child: Switch(
                                        activeTrackColor: switchActiveTrackColor,
                                        value: signInController.isRememberMe.value,
                                        activeColor: switchActiveColor,
                                        inactiveTrackColor: switchColor.withOpacity(0.2),
                                        onChanged: (bool value) {
                                          signInController.toggleSwitch();
                                        },
                                      ),
                                    ),
                                    Text(
                                      locale.value.rememberMe,
                                      style: secondaryTextStyle(color: darkGrayGeneral),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => ForgetPassword());
                              },
                              child: Text(
                                locale.value.forgotPassword,
                                style: primaryTextStyle(
                                  size: 12,
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.italic,
                                  decorationColor: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        32.height,
                        AppButton(
                          width: Get.width,
                          text: locale.value.signIn,
                          textStyle: appButtonTextStyleWhite,
                          onTap: () {
                            if (_signInformKey.currentState!.validate()) {
                              _signInformKey.currentState!.save();
                              signInController.saveForm();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  8.height,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(locale.value.notRegistered, style: secondaryTextStyle()),
                      4.width,
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Get.to(() => SignUpScreen());
                        },
                        child: Text(
                          locale.value.registerNow,
                          style: primaryTextStyle(
                            size: 12,
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                          ),
                        ).paddingSymmetric(horizontal: 8),
                      ),
                    ],
                  ),
                  16.height,
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: const Divider(color: borderColor),
                      ).expand(),
                      Text(locale.value.orSignInWith, style: primaryTextStyle(color: secondaryTextColor, size: 14)).paddingSymmetric(horizontal: 20),
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: const Divider(
                          color: borderColor,
                        ),
                      ).expand(),
                    ],
                  ),
                  16.height,
                  AppButton(
                    width: Get.width,
                    color: context.cardColor,
                    text: "",
                    textStyle: appButtonFontColorText,
                    onTap: () {
                      signInController.googleSignIn();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.imagesGoogleLogo,
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata_rounded),
                        ),
                        8.width,
                        Text(
                          locale.value.signInWithGoogle,
                          style: primaryTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  AppButton(
                    width: Get.width,
                    color: context.cardColor,
                    text: "",
                    textStyle: appButtonFontColorText,
                    onTap: () {
                      signInController.appleSignIn();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.imagesAppleLogo,
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata_rounded),
                        ),
                        8.width,
                        Text(
                          locale.value.signInWithApple,
                          style: primaryTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ).paddingTop(16).visible(isApple),
                ],
              ),
            ),
            Positioned(
              top: 40,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
