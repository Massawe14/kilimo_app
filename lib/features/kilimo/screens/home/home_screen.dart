import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kilimo_app/util/constants/colors.dart';
import 'package:kilimo_app/util/constants/text_strings.dart';

import '../../../../common/widgets/drawer/drawer.dart';
import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../weather/weather_screen.dart';
import '../weather/weather_forecast_screen.dart';
import 'widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TTexts.appName.tr,
          style: TextStyle(
            color: darkMode ? TColors.white : TColors.black,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WeatherForecastScreen())
                    );
                  },
                  child: const WeatherScreen()
                ),
                THomeCard(
                  image: 'assets/images/crops/maize.jpeg',
                  title: TTexts.maizeCropTitle.tr,
                  subtitle: TTexts.maizeCropDescription.tr,
                ),
                THomeCard(
                  image: 'assets/images/crops/beans.jpeg',
                  title: TTexts.beansCropTitle.tr,
                  subtitle: TTexts.beansCropDescription.tr,
                ),
                THomeCard(
                  image: 'assets/images/crops/rice.jpeg',
                  title: TTexts.riceCropTitle.tr,
                  subtitle: TTexts.riceCropDescription.tr,
                ),
                THomeCard(
                  image: 'assets/images/crops/cassava.jpeg',
                  title: TTexts.cassavaCropTitle.tr,
                  subtitle: TTexts.cassavaCropDescription.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
