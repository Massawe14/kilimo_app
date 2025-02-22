import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/helpers/helper_functions.dart';

class CultivationTipsScreen extends StatelessWidget {
  const CultivationTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Iconsax.arrow_left, 
              color: darkMode ? TColors.white : TColors.black,
            ),
          ),
          title: Text('cultivation_tips'.tr),
        ),
        body: SafeArea(
          child: Center(
            child: Text('coming_soon'.tr),
          ),
        ),
      ),
    );
  }
}
