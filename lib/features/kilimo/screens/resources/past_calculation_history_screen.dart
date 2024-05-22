import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/fertilizer_calculator/fertilizer_controller.dart';

class PastCalculationsScreen extends StatelessWidget {
  PastCalculationsScreen({super.key}); 

  final controller = Get.put(FertilizerController());

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Iconsax.arrow_left, 
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
        title: const Text('Calculation History')
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Calculation History')
        ),
      ),
    );
  }
}
