import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'disease.dart';

class DiseaseDatabase {
  Future<void> addInitialDiseases(Box<Disease> diseasesBox) async {
    try {
      // Add initial diseases only if the box is empty
      if (diseasesBox.isEmpty) {
        await diseasesBox.put('Northern leaf blight', Disease(
          name: 'Northern leaf blight',
          symptoms: ['Large grey cigar-shaped lesions'],
          causes: [
            'Is caused by the fungus called  Exserohilium turcicum',
            'Moderate to cool temperatures',
            'Relatively high humidity level',
          ],
          treatment: [
            'Antimalarial medications',
            'Supportive care',
          ]
        ));

        await diseasesBox.put('Common rust', Disease(
          name: 'Common rust',
          symptoms: [
            'A number of small tan spots develop on both the surfaces of the leaf and as a result',
            'The photosynthesis of the leaf reduces drastically',
          ],
          causes: [
            'High humidity levels',
            'Cold temperatures',
          ],
          treatment: [
            'Rest',
            'Fluids',
            'Over-the-counter medications',
          ]
        ));

        await diseasesBox.put('The Gray leaf spot', Disease(
          name: 'The Gray leaf spot',
          symptoms: [
            'Linear (and rectangular) lesions on the lower surface of the leaf in the early stage',
            'Leaf later turns into rust spots',
          ],
          causes: [
            'Cercospora zeae-maydis fungal pathogen',
            'Moderate to cool temperatures',
            'Relatively high humidity level',
          ],
          treatment: [
            'Antimalarial medications',
            'Supportive care',
          ]
        ));

        await diseasesBox.put('Healthy maize leaves', Disease(
          name: 'Healthy maize leaves',
          symptoms: ['Healthy'],
          causes: ['Healthy'],
          treatment: ['Healthy']
        ));
      } else {
        debugPrint('The box is not empty');
      }
    } catch (e) {
      // Handle errors in adding initial diseases
      debugPrint('Error adding initial diseases: $e');
    }
  }
}
