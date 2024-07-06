/* import 'package:get/get.dart';
import 'package:pet_care/utils/colors.dart';
import 'package:pet_care/utils/common_base.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../getx_controllers/add_pet_controller.dart';

class AddYourPetScreen extends StatelessWidget {
  AddYourPetScreen({Key? key}) : super(key: key);
  final AddPetController profileController = Get.put(AddPetController());

  Widget buildPetTypeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Type', style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
        8.height,
        HorizontalList(
          itemCount: profileController.petName.length,
          spacing: 16,
          padding: const EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (context, index) {
            bool isSelected = profileController.petSelectIndex.value == index;
            return Obx(
              () => InkWell(
                onTap: () {
                  profileController.petSelectIndex(index);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: boxDecorationDefault(color: isSelected ? primaryColor : null),
                  child: Text('${profileController.petName[index]}', style: secondaryTextStyle(color: isSelected ? white : null)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildBreedWidget() {
    return Container(
      decoration: boxDecorationDefault(
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: InputDecorator(
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
        ),
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                isDense: true,
                value: profileController.defaultValue.value,
                isExpanded: true,
                menuMaxHeight: 350,
                items: [
                  DropdownMenuItem(value: "", child: Text('Choose Pet Breed', style: secondaryTextStyle(size: 12))),
                  ...profileController.dropDowanListData.map<DropdownMenuItem<String>>((data) {
                    return DropdownMenuItem(
                      value: data['value'],
                      child: Text(data['title'], style: primaryTextStyle(size: 14)),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  // log("selected value $value");
                  if (value != null) {
                    profileController.defaultValue(value);
                  }
                }),
          ),
        ),
      ),
    ).paddingSymmetric(horizontal: 16);
  }

  Widget buildOptionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
        8.height,
        Obx(
          () => Row(
            children: [
              RadioListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: radius()),
                fillColor: MaterialStateProperty.all(primaryColor),
                title: Text("Female", style: secondaryTextStyle(size: 12)),
                value: 'Female',
                groupValue: profileController.genderOption.value,
                onChanged: (value) {
                  profileController.genderOption(value);
                },
              ).expand(),
              16.width,
              RadioListTile(
                value: 'Male',
                shape: RoundedRectangleBorder(borderRadius: radius()),
                tileColor: Colors.white,
                fillColor: MaterialStateProperty.all(primaryColor),
                title: Text("Male", style: secondaryTextStyle(size: 12)),
                groupValue: profileController.genderOption.value,
                onChanged: (value) {
                  profileController.genderOption(value);
                },
              ).expand(),
            ],
          ).paddingSymmetric(horizontal: 16),
        ),
      ],
    );
  }

  Widget buildBirthdateWidget() {
    return DropdownDatePicker(
      boxDecoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      isDropdownHideUnderline: true,
      width: 5,
      isExpanded: true,
      startYear: 1900,
      endYear: 2022,
      selectedDay: 14,
      selectedMonth: 10,
      selectedYear: 1993,
      onChangedDay: (value) => print('onChangedDay: $value'),
      onChangedMonth: (value) => print('onChangedMonth: $value'),
      onChangedYear: (value) => print('onChangedYear: $value'),
      yearFlex: 4,
      dayFlex: 3,
      monthFlex: 5,
    ).paddingSymmetric(horizontal: 16);
  }

  Widget buildWeightWidget() {
    return Container(
      decoration: boxDecorationDefault(
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: InputDecorator(
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
        ),
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                isDense: true,
                value: profileController.defaultWeightValue.value,
                isExpanded: true,
                menuMaxHeight: 350,
                items: [
                  DropdownMenuItem(value: "", child: Text('Choose Weight', style: secondaryTextStyle(size: 12))),
                  ...profileController.dropDowanListWeight.map<DropdownMenuItem<String>>((data) {
                    return DropdownMenuItem(
                      value: data['value'],
                      child: Text(data['title'], style: primaryTextStyle(size: 14)),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  if (value != null) {
                    profileController.defaultWeightValue(value);
                  }
                }),
          ),
        ),
      ),
    ).paddingSymmetric(horizontal: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: scafoldColor,
        leading: backButton(context),
        title: Text('Add Pet', style: boldTextStyle()),
        actions: [const Icon(Icons.arrow_forward_outlined, color: Colors.grey, size: 20).paddingSymmetric(horizontal: 16)],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                32.height,
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  decoration: boxDecorationDefault(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey), onPressed: () {}),
                ),
                16.height,
                Align(alignment: Alignment.center, child: Text('Upload Profile Photo', style: secondaryTextStyle())),
                64.height,
                AppTextField(
                  controller: profileController.nameCont,
                  textFieldType: TextFieldType.OTHER,
                  decoration: inputDecoration(
                    context,
                    labelText: 'Pet Name',
                    suffixIcon: const Icon(Icons.person_2_outlined, size: 15),
                  ),
                ).paddingSymmetric(horizontal: 16),
                32.height,
                buildPetTypeWidget(),
                32.height,
                Text('Breed', style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
                8.height,
                buildBreedWidget(),
                32.height,
                buildOptionWidget(),
                32.height,
                Text('Birthday', style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
                8.height,
                buildBirthdateWidget(),
                32.height,
                Text('Pet Weight', style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
                8.height,
                buildWeightWidget(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              color: scafoldColor,
              child: AppButton(
                width: Get.width,
                text: "Save",
                textStyle: const TextStyle(fontSize: 14, color: Colors.white),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 */