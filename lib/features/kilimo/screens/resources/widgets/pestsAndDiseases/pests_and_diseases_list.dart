import 'package:flutter/material.dart';

import 'pest_and_disease_card.dart';

class TPestsAndDiseasesList extends StatelessWidget {
  const TPestsAndDiseasesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (_, index) {
        return const TPestsAndDiseasesCard(
          image: 'assets/images/crops/maize.jpeg',
          title: 'Fungus',
          subtitle: 'Maize',
        );
      }
    );
  }
}