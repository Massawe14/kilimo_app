import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'disease_model.dart';

class DiseaseDatabase {
  static const _diseaseBoxName = 'diseases';

  Future<void> initDatabase() async {
    try {
      // Initialize Hive
      await Hive.initFlutter();

      // Register HiveAdapter for Disease class
      Hive.registerAdapter(DiseaseAdapter());

      // Open the box
      var diseasesBox = await Hive.openBox<Disease>(_diseaseBoxName);

      // Check if the box is empty
      if (diseasesBox.isEmpty) {
        await _addInitialDiseases(diseasesBox);
      }
      
      // Close the box when done
      await diseasesBox.close();
    } catch (e) {
      // Handle Hive initialization error 
      debugPrint('Error initializing Hive: $e');
    }
  }

  Future<void> _addInitialDiseases(Box<Disease> diseasesBox) async {
    try {
      // Add initial diseases only if the box is empty
      await diseasesBox.put('Northern leaf blight disease', Disease(
        name: 'Northern leaf blight disease',
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

      await diseasesBox.put('Common rust disease', Disease(
        name: 'Common rust disease',
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

      await diseasesBox.put('The Gray leaf spot (GLS)', Disease(
        name: 'The Gray leaf spot (GLS)',
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
    } catch (e) {
      // Handle errors in adding initial diseases
      debugPrint('Error adding initial diseases: $e');
    }
  }
}
