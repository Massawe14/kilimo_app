import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kilimo_app/util/constants/colors.dart';
import 'package:kilimo_app/util/constants/text_strings.dart';

import '../../../../common/widgets/drawer/drawer.dart';
import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import 'widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TTexts.appName,
          style: TextStyle(
            color: TColors.black,
          ),
        ),
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
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              THomeCard(
                image: 'assets/images/crops/maize.jpeg',
                title: 'Maize',
                subtitle: 'Card Subtitle',
              ),
              THomeCard(
                image: 'assets/images/crops/beans.jpeg',
                title: 'Beans',
                subtitle: 'Card Subtitle',
              ),
              THomeCard(
                image: 'assets/images/crops/rice.jpeg',
                title: 'Rice',
                subtitle: 'Card Subtitle',
              ),
              THomeCard(
                image: 'assets/images/crops/cassava.jpeg',
                title: 'Cassava',
                subtitle: 'Card Subtitle',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
