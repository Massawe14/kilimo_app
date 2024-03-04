import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../util/constants/sizes.dart';
import '../home/widgets/drawer.dart';
import '../home/widgets/popup_menu.dart';
import 'widgets/grid_items.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Survey', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.notification,
            ),
            onPressed: () {
              // Handle notification icon action
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert_outlined,
            ),
            onPressed: () {
              // Show the popup menu when the icon is clicked
              showPopupMenu(context);
            },
          ),
        ],
      ),
      drawer: const NavigationDrawerMenu(),
      body: Container(
        padding: const EdgeInsets.all(TSizes.spaceBtwItems),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return GridItem(index: index);
          },
        ),
      ),
    );
  }
}
