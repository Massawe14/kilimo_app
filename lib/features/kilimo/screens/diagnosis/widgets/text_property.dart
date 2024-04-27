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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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