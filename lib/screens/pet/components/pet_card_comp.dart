import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';

import '../../../components/cached_image_widget.dart';
import '../model/pet_list_res_model.dart';

class PetCard extends StatelessWidget {
  final PetData editProfile;
  const PetCard({super.key, required this.editProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            32.height,
            Hero(
              tag: "${editProfile.name}${editProfile.id}",
              child: CachedImageWidget(
                url: editProfile.petImage,
                firstName: editProfile.name,
                height: 90,
                width: 90,
                fit: BoxFit.cover,
                circle: true,
              ),
            ),
            16.height,
            Text(editProfile.name, style: primaryTextStyle(size: 18)),
            8.height,
            Text('${locale.value.breed}: ${editProfile.breed}', style: secondaryTextStyle(), textAlign: TextAlign.center),
            32.height,
          ],
        ));
  }
}
