import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../util/constants/colors.dart';

class AskCommunity extends StatelessWidget {
  const AskCommunity({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: const Text('Ask Community'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.attach_circle, color: TColors.green),
            onPressed: () {
              // Handle attach icon action
            },
          ),
          IconButton(
            icon: const Icon(Iconsax.send_1, color: TColors.green),
            onPressed: () {
              // Handle send icon action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                'Improve the probabilty of receiving the right answer', 
                style: Theme.of(context).textTheme.labelSmall,
              ),
              OutlinedButton(
                onPressed: () {
                  // Handle button press
                },
                child: const Text(
                  'Add Crop',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}