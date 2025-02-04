import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../util/constants/sizes.dart';
import 'widgets/recommendation_form.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Recommendation', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                'Guide Farmers with Effective Solutions for Healthy Crops!',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Recommendation Form
              TRecommendationForm(),
            ],
          ),
        ),
      ),
    );
  }
}
