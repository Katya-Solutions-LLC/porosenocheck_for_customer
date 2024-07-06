import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../components/app_scaffold.dart';
import '../../components/cached_image_widget.dart';
import 'upi_app_model.dart';

class UpiPayScreen extends StatefulWidget {
  final List<UpiResponse> installedUpiAppList;
  const UpiPayScreen(this.installedUpiAppList, {super.key});

  @override
  State<UpiPayScreen> createState() => _UpiPayScreenState();
}

class _UpiPayScreenState extends State<UpiPayScreen> {
  List<UpiApps> upiApps = [];

  @override
  void initState() {
    upiApps.addAll(
      UpiApps()
          .upiAppList
          .where((p0) => widget.installedUpiAppList.any((installedList) => installedList.packageName == p0['packageName']))
          .map((element) => UpiApps(name: element['name'], imagePath: element['image'], packageName: element['packageName'])),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: "Upi Apps",
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: upiApps.length,
        itemBuilder: (BuildContext context, int index) {
          UpiApps data = upiApps[index];

          return GestureDetector(
            onTap: () {
              Get.back(result: data.packageName.validate());
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              color: context.scaffoldBackgroundColor,
              margin: const EdgeInsets.all(10),
              child: CachedImageWidget(
                url: data.imagePath.validate(),
                height: 80,
                circle: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
