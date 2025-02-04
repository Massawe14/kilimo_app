import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../util/constants/sizes.dart';
import 'widgets/agrovet_form.dart';

class AgrovetScreen extends StatelessWidget {
  const AgrovetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Agrovet', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                'Empower Farmers by Connecting Trusted Agrovet Suppliers!',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              TAgrovetForm(),
            ],
          ),
        ),
      ),
    );
  }
}
