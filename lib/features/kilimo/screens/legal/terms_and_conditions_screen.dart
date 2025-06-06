import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';
import '../../../../util/helpers/helper_functions.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key}); 

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
        title: Text("terms_and_conditions".tr),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 150)).then((value) {
            return rootBundle.loadString('assets/legal/terms_and_conditions.md');
          }), 
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Markdown(
                data: snapshot.data!,
                shrinkWrap: true, // Ensure the content wraps correctly
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      ),
    );
  }
}
