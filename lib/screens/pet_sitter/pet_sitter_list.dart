import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/screens/pet_sitter/pet_sitter_controller.dart';
import 'package:porosenocheck/screens/pet_sitter/pet_sitter_item_component.dart';
import 'package:porosenocheck/screens/pet_sitter/pet_sitter_model.dart';

import '../../../components/app_scaffold.dart';
import '../../../utils/empty_error_state_widget.dart';
import 'pet_sitter_list_shimmer.dart';

class PetSitterListScreen extends StatelessWidget {
  PetSitterListScreen({Key? key}) : super(key: key);
  final PetSitterController petSitterController = Get.put(PetSitterController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.petSitters,
      isLoading: petSitterController.isLoading,
      body: Obx(
        () => SnapHelperWidget(
          future: petSitterController.getPetSitterList.value,
          errorBuilder: (error) {
            return SizedBox(
              height: Get.height * 0.7,
              child: NoDataWidget(
                title: error,
                retryText: locale.value.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  petSitterController.init();
                },
              ).paddingSymmetric(horizontal: 16),
            );
          },
          loadingWidget: const PetSitterListShimmer().paddingTop(16),
          onSuccess: (petSitters) {
            return AnimatedScrollView(
              padding: const EdgeInsets.only(bottom: 50, top: 16),
              listAnimationType: ListAnimationType.FadeIn,
              physics: const AlwaysScrollableScrollPhysics(),
              onSwipeRefresh: () async {
                petSitterController.page(1);
                return await petSitterController.init(showloader: false);
              },
              onNextPage: () async {
                if (!petSitterController.isLastPage.value) {
                  petSitterController.page(petSitterController.page.value + 1);
                  petSitterController.init();
                }
              },
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Obx(
                    () => Wrap(
                      runSpacing: 16,
                      spacing: 16,
                      children: List.generate(petSitters.length, (index) {
                        return PetSitterItemComponent(
                          petSitter: PetSitterItem(
                            id: petSitters[index].id,
                            fullName: petSitters[index].fullName,
                            email: petSitters[index].email,
                            mobile: petSitters[index].mobile,
                            profileImage: petSitters[index].profileImage.value,
                          ),
                        );
                      }),
                    ),
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
