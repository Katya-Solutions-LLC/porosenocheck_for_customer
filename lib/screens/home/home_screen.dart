import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/dashboard/dashboard_res_model.dart';
import 'package:porosenocheck/screens/home/home_screen_shimmer.dart';
import '../../components/app_scaffold.dart';
import '../../main.dart';
import '../../utils/empty_error_state_widget.dart';
import '../pet_sitter/pet_sitter_home_component.dart';
import 'blog/blog_home_component.dart';
import 'components/choose_service_components.dart';
import 'components/greetings_component.dart';
import 'components/sliders_component.dart';
import 'components/upcoming_appointment_components.dart';
import 'event/your_events_components.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      body: RefreshIndicator(
        onRefresh: () async {
          return await homeScreenController.getDashboardDetail(isFromSwipRefresh: true);
        },
        child: Obx(
          () => SnapHelperWidget(
            future: homeScreenController.getDashboardDetailFuture.value,
            initialData: homeScreenController.dashboardData.value.systemService.isEmpty ? null : DashboardRes(data: homeScreenController.dashboardData.value),
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.value.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  homeScreenController.init();
                },
              ).paddingSymmetric(horizontal: 16);
            },
            loadingWidget: const HomeScreenShimmer(showGreeting: true),
            onSuccess: (dashboardData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    32.height,
                    GreetingsComponent(),
                    16.height,
                    Obx(
                      () => homeScreenController.isLoading.value
                          ? const HomeScreenShimmer()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SlidersComponent(),
                                ChooseServiceComponents(),
                                UpcomingAppointmentComponents(),
                                ChoosePetSitterComponents(),
                                YourEventsComponents(events: homeScreenController.dashboardData.value.event),
                                BlogHomeComponent(),
                              ],
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
