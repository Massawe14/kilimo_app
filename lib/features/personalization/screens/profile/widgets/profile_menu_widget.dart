import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/helpers/helper_functions.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key, 
    required this.title, 
    required this.icon, 
    required this.onPress, 
    required this.endIcon, 
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final iconColor = dark ? TColors.primary : TColors.accent;
    
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium?.apply(color: textColor)),
      trailing: endIcon ? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: TColors.grey.withOpacity(0.1),
        ),
        child: const Icon(Iconsax.arrow_right_3, size: 18.0, color: TColors.grey)
      ) : null,
    );
  }
}
