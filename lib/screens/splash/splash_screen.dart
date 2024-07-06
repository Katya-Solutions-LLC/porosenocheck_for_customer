import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:porosenocheck/utils/app_common.dart';
import '../../components/app_logo_widget.dart';
import '../../components/app_scaffold.dart';

import '../../generated/assets.dart';
import 'splash_controller.dart';
import '../../utils/constants.dart';

class SplashScreen extends StatelessWidget {
  final SplashScreenController splashController = Get.put(SplashScreenController());
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      scaffoldBackgroundColor: isDarkMode.value ? const Color(0xFF0C0910) : const Color(0xFFFCFCFC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isDarkMode.value ? Assets.imagesporosenocheckLoaderDark : Assets.imagesporosenocheckLoaderLight,
              height: Constants.appLogoSize,
              width: Constants.appLogoSize,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const AppLogoWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
