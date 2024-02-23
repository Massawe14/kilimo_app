import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'diagnosis_screen.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Survey'
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to another screen on box click
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DiagnosisScreen(),
                ),
              );
            },
            child: GFCard(
              boxFit: BoxFit.cover,
              image: Image.network(
                'https://example.com/crop_image_$index.jpg',
              ),
              titlePosition: GFPosition.end,
              content: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.transparent],
                  ),
                ),
                child: GFTypography(
                  text: 'Crop Name $index',
                  textColor: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
