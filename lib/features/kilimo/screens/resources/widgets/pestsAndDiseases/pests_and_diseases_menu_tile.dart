import 'package:flutter/material.dart';

class TPestsAndDiseasesMenuTile extends StatelessWidget {
  const TPestsAndDiseasesMenuTile({
    super.key, 
    required this.image, 
    required this.title, 
    required this.subTitle, 
    required this.icon, 
  });

  final IconData icon;
  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(image: AssetImage(image)),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: Icon(icon),
    );
  }
}
