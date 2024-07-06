import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/zoom_image_screen.dart';
import '../../../../components/cached_image_widget.dart';
import '../product_controller.dart';

class ProductSlider extends StatelessWidget {
  final List<String> productGallaryData;
  final ProductDetailController productController;

  const ProductSlider({super.key, required this.productController, required this.productGallaryData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          PageView.builder(
            controller: productController.pageController,
            reverse: false,
            itemCount: productGallaryData.length,
            itemBuilder: (_, i) {
              return CachedImageWidget(url: productGallaryData[i].toString(), height: 330, width: Get.width, fit: BoxFit.cover).onTap(() {
                if (productGallaryData.isNotEmpty) {
                  ZoomImageScreen(
                    galleryImages: productGallaryData.map((e) => e).toList(),
                    index: 0,
                  ).launch(context);
                }
              });
            },
          ),
          Positioned(
            bottom: 8,
            right: 0,
            left: 0,
            child: DotIndicator(
              pageController: productController.pageController,
              pages: productGallaryData,
              indicatorColor: grey,
              unselectedIndicatorColor: lightGray,
              currentBoxShape: BoxShape.rectangle,
              boxShape: BoxShape.rectangle,
              currentBorderRadius: radius(8),
              borderRadius: radius(8),
              currentDotSize: 26,
              currentDotWidth: 6,
              dotSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
