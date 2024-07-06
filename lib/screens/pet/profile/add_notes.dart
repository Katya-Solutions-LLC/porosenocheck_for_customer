import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/chat_gpt_loder.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_common.dart';
import '../my_pets_controller.dart';
import 'pet_profile_controller.dart';

import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';

class AddNote extends StatelessWidget {
  AddNote({Key? key}) : super(key: key);
  final PetProfileController petProfileController = Get.find();
  final GlobalKey<FormState> _noteformKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: "${myPetsScreenController.selectedPetProfile.value.name}'${locale.value.sNotes}",
      actions: [
        GestureDetector(
          onTap: () {
            showConfirmDialogCustom(
              getContext,
              primaryColor: primaryColor,
              negativeText: locale.value.cancel,
              positiveText: locale.value.yes,
              onAccept: (_) {
                petProfileController.deleteNote(isFromEditNote: true);
              },
              dialogType: DialogType.DELETE,
              title: locale.value.areYouSureWantDeleteNote,
            );
          },
          behavior: HitTestBehavior.translucent,
          child: commonLeadingWid(imgPath: Assets.iconsIcDeleteReview, icon: Icons.delete_outline, size: 24).paddingRight(16),
        ).visible(petProfileController.selectedNote.value.id > 0),
      ],
      isLoading: petProfileController.isLoading,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _noteformKey,
              child: Column(
                children: [
                  commonDivider,
                  16.height,
                  AppTextField(
                    title: locale.value.title,
                    textStyle: primaryTextStyle(size: 12),
                    textFieldType: TextFieldType.NAME,
                    controller: petProfileController.titleCont,
                    decoration: inputDecoration(context, hintText: "${locale.value.eG}  ${locale.value.groomingFor} ${myPetsScreenController.selectedPetProfile.value.name} ", fillColor: context.cardColor, filled: true),
                  ).paddingSymmetric(horizontal: 16),
                  16.height,
                  AppTextField(
                    title: "${locale.value.noteFor} ${myPetsScreenController.selectedPetProfile.value.name}",
                    textStyle: primaryTextStyle(size: 12),
                    textFieldType: TextFieldType.MULTILINE,
                    minLines: 5,
                    enableChatGPT: appConfigs.value.enableChatGpt,
                    promptFieldInputDecorationChatGPT: inputDecoration(context, hintText: locale.value.writeHere, fillColor: context.scaffoldBackgroundColor, filled: true),
                    testWithoutKeyChatGPT: appConfigs.value.testWithoutKey,
                    loaderWidgetForChatGPT: const ChatGPTLoadingWidget(),
                    controller: petProfileController.noteCont,
                    decoration: inputDecoration(context, hintText: locale.value.writeHere, fillColor: context.cardColor, filled: true),
                  ).paddingSymmetric(horizontal: 16),
                  8.height,
                  setAsPrimaryWidget(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AppButton(
              width: Get.width,
              text: locale.value.submit,
              textStyle: const TextStyle(color: containerColor),
              onTap: () {
                if (_noteformKey.currentState!.validate()) {
                  _noteformKey.currentState!.save();
                  if (!petProfileController.isLoading.value) petProfileController.addEditNote();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  /// region Service List Widget
  Widget setAsPrimaryWidget() {
    return Obx(
      () => ListTileTheme(
        horizontalTitleGap: 0.0,
        child: CheckboxListTile(
          value: petProfileController.selectedNote.value.isPrivate.value,
          checkColor: white,
          title: Text(locale.value.setAsPrivateNote, style: primaryTextStyle(color: isDarkMode.value ? textPrimaryColorGlobal : primaryColor, size: 14)),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          checkboxShape: RoundedRectangleBorder(borderRadius: radius(5)),
          side: const BorderSide(color: primaryColor),
          dense: true,
          activeColor: isDarkMode.value ? primaryColor : primaryColor,
          onChanged: (value) {
            petProfileController.selectedNote.value.isPrivate(!petProfileController.selectedNote.value.isPrivate.value);
          },
        ),
      ).paddingSymmetric(horizontal: 8),
    );
  }
}
