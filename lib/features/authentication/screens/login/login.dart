import 'package:flutter/material.dart';

import '../../../../common/styles/spacing_styles.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                // Logo, Title & SubTitle
                const TLoginHeader(),
                // Form
                const TLoginForm(),
                // Divider
                // TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
                // const SizedBox(height: TSizes.spaceBtwSections),
                // // Footer
                // const TSocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
