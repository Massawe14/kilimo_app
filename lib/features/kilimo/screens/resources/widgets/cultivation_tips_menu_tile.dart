import 'package:flutter/material.dart';

import '../../../../../util/constants/colors.dart';

class TCultivationTipsMenuTile extends StatelessWidget {
  const TCultivationTipsMenuTile({
    super.key, 
    required this.icon, 
    required this.title,  
    this.trailing, 
    this.onTap,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 25, color: TColors.accent),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      trailing: Icon(icon, color: TColors.dark),
      onTap: onTap,
    );
  }
}
