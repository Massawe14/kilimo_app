import 'package:flutter/material.dart';

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
                title: 'Beans',
                onTap: () {},
              ),
              TVerticalImageText(
                image: TImages.maizeCategory,
                title: 'Maize',
                onTap: () {},
              ),
              TVerticalImageText(
                image: TImages.cassavaCategory,
                title: 'Cassava',
                onTap: () {},
              ),
              TVerticalImageText(
                image: TImages.riceCategory,
                title: 'Rice',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
