import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kilimo_app/features/authentication/controllers/signup/signup_controller.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../../../util/constants/text_strings.dart';
import '../../../../../util/helpers/helper_functions.dart';

class TTermsAndConditonCheckbox extends StatelessWidget {
  const TTermsAndConditonCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value,
            ),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '${TTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: '${TTexts.privacyPolicy} ', style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? TColors.white : TColors.info,
                decoration: TextDecoration.underline,
                decorationColor: dark ? TColors.white : TColors.info,
              )),
              TextSpan(text: '${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: TTexts.termsOfUse, style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? TColors.white : TColors.info,
                decoration: TextDecoration.underline,
                decorationColor: dark ? TColors.white : TColors.info,
              )),
            ],
          ),
        ),
      ],
    );
  }
}
