import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../booking_module/services/service_navigation.dart';
import '../../dashboard/dashboard_res_model.dart';

class ServiceCard extends StatelessWidget {
  final SystemService service;
  final double width;
  final double height;
  final Widget? child;
  final bool showSubTexts;
  const ServiceCard({
    super.key,
    required this.service,
    this.width = 130,
    this.height = 130,
    this.showSubTexts = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: boxDecorationDefault(color: context.cardColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showSubTexts) 12.height,
          Hero(
              tag: service.serviceImage + service.id.toString(),
              child: CachedImageWidget(
                url: service.serviceImage,
                height: 50,
                width: 50,
                usePlaceholderIfUrlEmpty: false,
              )),
          12.height,
          Hero(tag: service.name + service.id.toString(), child: Text(getServiceNameByServiceElement(serviceSlug: service.slug), style: primaryTextStyle(decoration: TextDecoration.none))),
          if (showSubTexts) 12.height,
          if (showSubTexts) Text(service.description, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: secondaryTextStyle()).paddingSymmetric(horizontal: 14),
          if (showSubTexts) 12.height,
        ],
      ),
    );
  }
}
