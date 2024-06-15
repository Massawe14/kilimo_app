import 'package:flutter/material.dart';

import '../../../../../../util/constants/colors.dart';

class TCultivationTipsMenuTile extends StatelessWidget {
  const TCultivationTipsMenuTile({
    super.key, 
    required this.leading, 
    required this.title,  
    this.trailing, 
    this.onTap,
  });

  final IconData leading;
  final String title;
  final IconData? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leading, size: 25, color: TColors.accent),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      trailing: Icon(trailing, color: TColors.dark),
      onTap: onTap,
    );
  }
}
