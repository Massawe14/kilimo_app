import 'package:flutter/material.dart';

import '../../../util/constants/colors.dart';
import '../../../util/device/device_utility.dart';
import '../../../util/helpers/helper_functions.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  // If you want to add the background color to tabs you have to wrap them in material widget.
  // To do that are need [PreferredSized] widget and that's why created custom class. [PreferredSizedWidget]
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : TColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: TColors.accent,
        unselectedLabelColor: TColors.darkGrey,
        labelColor: dark ? TColors.white : TColors.accent,
      ),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}