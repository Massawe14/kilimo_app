import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kilimo_app/features/kilimo/screens/diagnosis/diagnosis_screen.dart';
import 'package:kilimo_app/util/constants/colors.dart';

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        print("Tapped on GridItem $index");
        Get.to(() => DiagnosisScreen(index: index));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: TColors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/crops/beans.jpeg',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Text('Title $index', style: const TextStyle(color: TColors.white)),
          ],
        ),
      ),
    );
  }
}
