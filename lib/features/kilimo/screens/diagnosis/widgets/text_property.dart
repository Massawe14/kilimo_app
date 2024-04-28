import 'package:flutter/material.dart';

class TextProperty extends StatelessWidget {
  const TextProperty({
    super.key, 
    required this.title, 
    required this.items
  });

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          title: Text(
            '$title:',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) => Text(item)).toList(),
          ),
        ),
      ],
    );
  }
}