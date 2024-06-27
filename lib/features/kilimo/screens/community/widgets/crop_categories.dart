import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text_widget/vertical_image_text.dart';
import '../../../../../util/constants/image_strings.dart';

class CropCategories extends StatelessWidget {
  const CropCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: [
              TVerticalImageText(
                image: TImages.beanCategory,
                title: 'beans'.tr,
                onTap: () {},
              ),
              TVerticalImageText(
                image: TImages.maizeCategory,
                title: 'maize'.tr,
                onTap: () {},
              ),
              TVerticalImageText(
                image: TImages.cassavaCategory,
                title: 'cassava'.tr,
                onTap: () {},
              ),
              TVerticalImageText(
                image: TImages.riceCategory,
                title: 'rice'.tr,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
